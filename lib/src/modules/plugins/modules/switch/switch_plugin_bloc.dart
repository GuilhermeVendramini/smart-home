import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../src/repositories/hasura/plugins/hasura_plugins_repository.dart';
import '../../../../../src/shared/models/device/device_model.dart';
import '../../../../shared/languages/pt-br/strings.dart';
import 'switch_plugin_validators.dart';

enum SavePluginState { SAVING, SUCCESS, FAIL }

class SwitchPluginBloc extends ChangeNotifier with SwitchPluginValidators {
  final HasuraPluginsRepository _pluginsRepository;
  final DeviceModel _device;

  SwitchPluginBloc(this._pluginsRepository, this._device);

  final _topicController = BehaviorSubject<String>();
  final _messageOnController = BehaviorSubject<String>();
  final _messageOffController = BehaviorSubject<String>();
  final _statusController = BehaviorSubject<bool>();
  final _stateController = BehaviorSubject<SavePluginState>();

  String message;

  @override
  void dispose() async {
    _topicController.close();
    _messageOnController.close();
    _messageOffController.close();
    _statusController.close();
    _stateController.close();
    super.dispose();
  }
}

class SwitchPlugin extends SwitchPluginBloc {
  SwitchPlugin(HasuraPluginsRepository pluginsRepository, DeviceModel device)
      : super(pluginsRepository, device);

  Stream<String> get getTopic =>
      _topicController.stream.transform(validateTopic);

  Stream<String> get getMessageOn =>
      _messageOnController.stream.transform(validateMessageOn);

  Stream<String> get getMessageOff =>
      _messageOffController.stream.transform(validateMessageOff);

  Stream<bool> get getStatus => _statusController.stream;

  Stream<SavePluginState> get getState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest3(
      getTopic, getMessageOn, getMessageOff, (a, b, c) => true);

  Function(String) get changeTopic => _topicController.sink.add;

  Function(String) get changeMessageOn => _messageOnController.sink.add;

  Function(String) get changeMessageOff => _messageOffController.sink.add;

  Function(bool) get changeStatus => _statusController.sink.add;
}

class SwitchPluginProvider extends SwitchPlugin {
  SwitchPluginProvider(
      HasuraPluginsRepository pluginsRepository, DeviceModel device)
      : super(pluginsRepository, device);

  Future<bool> save() async {
    try {
      _stateController.add(SavePluginState.SAVING);

      await _pluginsRepository.savePlugin(
          type: 'switch',
          status: _statusController.value,
          deviceId: _device.id,
          config: {
            "topic": _topicController.value,
            "messageOn": _messageOnController.value,
            "messageOff": _messageOffController.value,
          });

      message = Strings.switchSavedSuccessfully;
      _stateController.add(SavePluginState.SUCCESS);
      return true;
    } catch (e) {
      message = Strings.switchErrorSaving;
      _stateController.add(SavePluginState.FAIL);
      print('switch_plugin_bloc:save() $e');
      return false;
    }
  }
}
