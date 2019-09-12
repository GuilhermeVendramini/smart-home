import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;
import 'package:rxdart/subjects.dart';

import '../../../../app_bloc.dart';
import '../../../../shared/languages/pt-br/strings.dart';
import '../../../../shared/models/plugin/plugin_model.dart';

enum PluginState { LOADING, SUCCESS, FAIL, IDLE }

class SwitchPluginBloc extends ChangeNotifier {
  final PluginModel _plugin;
  final AppProvider _appBloc;

  SwitchPluginBloc(this._plugin, this._appBloc);

  final _statusController = BehaviorSubject<bool>();
  final _stateController = BehaviorSubject<PluginState>();
  String message;

  @override
  void dispose() async {
    _stateController.close();
    _statusController.close();
    super.dispose();
  }
}

class SwitchPlugin extends SwitchPluginBloc {
  SwitchPlugin(PluginModel plugin, AppProvider appBloc)
      : super(plugin, appBloc);

  Stream<bool> get getStatus => _statusController.stream;

  Stream<PluginState> get getState => _stateController.stream;
}

class SwitchPluginProvider extends SwitchPlugin {
  SwitchPluginProvider(PluginModel plugin, AppProvider appBloc)
      : super(plugin, appBloc);

  Future<bool> switchPower() async {
    try {
      _stateController.add(PluginState.LOADING);
      final mqtt.MqttClientPayloadBuilder builder =
          mqtt.MqttClientPayloadBuilder();

      builder.addString('ON');
      _appBloc.getMqttClient.publishMessage(
        'topico',
        mqtt.MqttQos.values[0],
        builder.payload,
        retain: false,
      );
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
