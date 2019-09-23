import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/models/mqtt/mqtt_message_model.dart';

class AppBloc with ChangeNotifier {
  mqtt.MqttClient _mqttClient;
  final BehaviorSubject<bool> _mqttConnectionStatus = BehaviorSubject<bool>();
  final BehaviorSubject<MqttMessageModel> _mqttMessages =
      BehaviorSubject<MqttMessageModel>();

  @override
  void dispose() {
    _mqttConnectionStatus.close();
    _mqttMessages.close();
    super.dispose();
  }
}

class App extends AppBloc {
  Stream<MqttMessageModel> get getMqttMessages {
    return _mqttMessages.stream;
  }

  mqtt.MqttClient get getMqttClient {
    return _mqttClient;
  }

  Stream<bool> get getMqttConnectionStatus => _mqttConnectionStatus.stream;
}

class AppProvider extends App {
  AppProvider() {
    mqttConnect();
  }

  void mqttDisconnect() {
    if (_mqttClient != null && _mqttClient.connectionStatus != null) {
      _mqttClient.disconnect();
      print('MQTT client disconnected');
    }
    _mqttOnDisconnected();
  }

  void _mqttOnDisconnected() {
    _mqttClient = null;
    _mqttMessages.drain();
    _mqttConnectionStatus.add(false);
    print('MQTT client setted null');
  }

  Future<bool> mqttConnect() async {
    if (_mqttClient != null && _mqttClient.connectionStatus != null) {
      print('Already connected');
      return true;
    }

    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.getString('mqttBroker') == null ||
        _prefs.getString('mqttClientIdentifier') == null ||
        _prefs.getString('mqttPort') == null ||
        _prefs.getString('mqttUser') == null ||
        _prefs.getString('mqttPassword') == null) {
      return false;
    }

    try {
      final _mqttConnect = mqtt.MqttClient(_prefs.getString('mqttBroker'), '');
      _mqttConnect.logging(on: true);
      _mqttConnect.keepAlivePeriod = 30;
      _mqttConnect.onDisconnected = _mqttOnDisconnected;
      final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
          .withClientIdentifier(_prefs.getString('mqttClientIdentifier'))
          .startClean()
          .keepAliveFor(30)
          .withWillQos(mqtt.MqttQos.atLeastOnce);
      print('MQTT client connecting....');
      _mqttConnect.connectionMessage = connMess;
      _mqttConnect.port = int.tryParse(_prefs.getString('mqttPort'));

      await _mqttConnect.connect(
          _prefs.getString('mqttUser'), _prefs.getString('mqttPassword'));

      _mqttConnect.updates.listen(_onMessage);
      _mqttClient = _mqttConnect;

      _mqttConnectionStatus.add(true);
      return true;
    } catch (e) {
      mqttDisconnect();
      print('mqtt_bloc:connect() $e');
      return false;
    }
  }

  void _onMessage(List<mqtt.MqttReceivedMessage> event) {
    final mqtt.MqttPublishMessage recMess =
        event[0].payload as mqtt.MqttPublishMessage;
    final String message =
        mqtt.MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    _mqttMessages.add(MqttMessageModel(
      topic: event[0].topic,
      message: message,
      qos: recMess.payload.header.qos,
    ));
  }
}
