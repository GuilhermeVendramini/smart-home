import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/models/user/user_model.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class AppBloc with ChangeNotifier {
  UserModel _user;
  final _stateController = BehaviorSubject<LoginState>();
  mqtt.MqttClient _mqttClient;

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }
}

class App extends AppBloc {
  UserModel get getUser {
    return _user;
  }

  set setMqttClient(mqtt.MqttClient mqttClient) {
    _mqttClient = mqttClient;
  }

  mqtt.MqttClient get getMqttClient {
    return _mqttClient;
  }

  Stream<LoginState> get getState => _stateController.stream;
}

class AppMqtt extends App {
  void mqttDisconnect() {
    if (getMqttClient != null && getMqttClient.connectionStatus != null) {
      getMqttClient.disconnect();
    }
    _mqttOnDisconnected();
  }

  void _mqttOnDisconnected() {
    setMqttClient = null;
    print('MQTT client disconnected');
  }

  Future<bool> mqttConnect() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();

    if (_prefs.getString('mqttBroker') == null ||
        _prefs.getString('mqttClientIdentifier') == null ||
        _prefs.getString('mqttPort') == null ||
        _prefs.getString('mqttUser') == null ||
        _prefs.getString('mqttPassword') == null
    ) {
      return false;
    }

    setMqttClient = mqtt.MqttClient(_prefs.getString('mqttBroker'), '');
    getMqttClient.logging(on: true);
    getMqttClient.keepAlivePeriod = 30;
    getMqttClient.onDisconnected = _mqttOnDisconnected;
    final mqtt.MqttConnectMessage connMess = mqtt.MqttConnectMessage()
        .withClientIdentifier(_prefs.getString('mqttClientIdentifier'))
        .startClean()
        .keepAliveFor(30)
        .withWillQos(mqtt.MqttQos.atLeastOnce);
    print('MQTT client connecting....');
    getMqttClient.connectionMessage = connMess;
    getMqttClient.port = int.tryParse(_prefs.getString('mqttPort'));
    try {
      await getMqttClient.connect(
          _prefs.getString('mqttUser'), _prefs.getString('mqttPassword'));
      return true;
    } catch (e) {
      mqttDisconnect();
      print('mqtt_bloc:connect() $e');
      return false;
    }
  }
}

class AppProvider extends AppMqtt {
  Future<Null> cleanUser() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _user = null;
    _prefs.remove('name');
    _prefs.remove('id');
    _stateController.add(LoginState.IDLE);
  }

  Future<bool> userIsLogged() async {
    _stateController.add(LoginState.LOADING);
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      if (_prefs.getString('name') != null &&
          _prefs
              .getString('name')
              .isNotEmpty) {
        _user = UserModel(
          id: _prefs.getInt('id'),
          name: _prefs.getString('name'),
        );
        _stateController.add(LoginState.SUCCESS);
        return true;
      }
      _stateController.add(LoginState.IDLE);
      return false;
    } catch (e) {
      print('app_bloc:userIsLogged() $e');
      _stateController.add(LoginState.FAIL);
      return false;
    }
  }

  Future<Null> setUser(UserModel user) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _user = user;
    _prefs.setString('name', user.name);
    _prefs.setInt('id', user.id);
    _stateController.add(LoginState.SUCCESS);
  }
}
