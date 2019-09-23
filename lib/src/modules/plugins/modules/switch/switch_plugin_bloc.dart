import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:rxdart/subjects.dart';

import '../../../../app_bloc.dart';
import '../../../../shared/languages/en/strings.dart';
import '../../../../shared/models/plugin/plugin_model.dart';

enum PluginState { LOADING, SUCCESS, FAIL, IDLE }

class SwitchPluginBloc extends ChangeNotifier {
  final PluginModel _plugin;
  final AppProvider _appBloc;

  SwitchPluginBloc(this._plugin, this._appBloc) {
    if (_appBloc.getMqttClient != null &&
        _appBloc.getMqttClient.connectionStatus != null) {
      _appBloc.getMqttClient
          .subscribe(_plugin.config['topicResult'], mqtt.MqttQos.exactlyOnce);
    }
  }

  final _switchStatusController = BehaviorSubject<bool>();
  final _stateController = BehaviorSubject<PluginState>();
  String message;

  @override
  void dispose() async {
    _stateController.close();
    _switchStatusController.close();
    if (_appBloc.getMqttClient != null &&
        _appBloc.getMqttClient.connectionStatus != null) {
      _appBloc.getMqttClient.unsubscribe(_plugin.config['topicResult']);
    }
    super.dispose();
  }
}

class SwitchPlugin extends SwitchPluginBloc {
  SwitchPlugin(PluginModel plugin, AppProvider appBloc)
      : super(plugin, appBloc);

  Stream<bool> get getSwitchStatus => _switchStatusController.stream;

  Stream<PluginState> get getState => _stateController.stream;
}

class SwitchPluginProvider extends SwitchPlugin {
  SwitchPluginProvider(PluginModel plugin, AppProvider appBloc)
      : super(plugin, appBloc) {
    if (_appBloc.getMqttClient != null &&
        _appBloc.getMqttClient.connectionStatus != null) {
      final mqtt.MqttClientPayloadBuilder _builder =
          mqtt.MqttClientPayloadBuilder();
      _builder.addString('state');
      _publishMessage(_builder);
      _listenMessage();
    }
  }

  void _publishMessage(mqtt.MqttClientPayloadBuilder builder) {
    _appBloc.getMqttClient.publishMessage(
      _plugin.config['topic'],
      mqtt.MqttQos.values[0],
      builder.payload,
      retain: false,
    );
  }

  void _listenMessage() {
    _appBloc.getMqttMessages.listen((onData) {
      if (!_switchStatusController.isClosed) {
        if (onData.message == _plugin.config['resultOn']) {
          _switchStatusController.add(true);
        } else {
          _switchStatusController.add(false);
        }
      }
    });
  }

  Future<bool> switchPower() async {
    try {
      _stateController.add(PluginState.LOADING);
      final mqtt.MqttClientPayloadBuilder _builder =
          mqtt.MqttClientPayloadBuilder();

      if (_switchStatusController.value != null &&
          _switchStatusController.value) {
        _builder.addString(_plugin.config['messageOff']);
      } else {
        _builder.addString(_plugin.config['messageOn']);
      }

      _publishMessage(_builder);

      _listenMessage();

      _stateController.add(PluginState.SUCCESS);
      return true;
    } catch (e) {
      message = Strings.switchErrorSendingMessage;
      print('switch_plugin_bloc:switchPower() $e');
      _stateController.add(PluginState.FAIL);
      return false;
    }
  }
}
