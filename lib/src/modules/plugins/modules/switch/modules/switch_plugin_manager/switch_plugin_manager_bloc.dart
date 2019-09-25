import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../../repositories/sqflite/plugins/sqflite_plugins_repository.dart';
import '../../../../../../shared/languages/en/strings.dart';
import '../../../../../../shared/models/device/device_model.dart';
import '../../../../../../shared/models/plugin/plugin_model.dart';
import 'switch_plugin_manager_validators.dart';

enum SavePluginState { SAVING, SUCCESS, FAIL }

class SwitchPluginManagerBloc extends ChangeNotifier
    with SwitchPluginManagerValidators {
  final SQFLitePluginsRepository _pluginsRepository;
  final DeviceModel _device;
  final PluginModel _currentPlugin;

  SwitchPluginManagerBloc(
      this._pluginsRepository, this._device, this._currentPlugin);

  final _topicController = BehaviorSubject<String>();
  final _messageOnController = BehaviorSubject<String>();
  final _messageOffController = BehaviorSubject<String>();
  final _topicResultController = BehaviorSubject<String>();
  final _resultOnController = BehaviorSubject<String>();
  final _resultOffController = BehaviorSubject<String>();
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
    _topicResultController.close();
    _resultOnController.close();
    _resultOffController.close();
    super.dispose();
  }
}

class SwitchPluginManager extends SwitchPluginManagerBloc {
  SwitchPluginManager(SQFLitePluginsRepository pluginsRepository,
      DeviceModel device, PluginModel plugin)
      : super(pluginsRepository, device, plugin);

  DeviceModel get getDevice {
    return _device;
  }

  PluginModel get getCurrentPlugin {
    return _currentPlugin;
  }

  Stream<String> get getTopic =>
      _topicController.stream.transform(validateTopic);

  Stream<String> get getMessageOn =>
      _messageOnController.stream.transform(validateMessageOn);

  Stream<String> get getMessageOff =>
      _messageOffController.stream.transform(validateMessageOff);

  Stream<String> get getTopicResult =>
      _topicResultController.stream.transform(validateTopicResult);

  Stream<String> get getResultOn =>
      _resultOnController.stream.transform(validateResultOn);

  Stream<String> get getResultOff =>
      _resultOffController.stream.transform(validateResultOff);

  Stream<bool> get getStatus => _statusController.stream;

  Stream<SavePluginState> get getState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest6(
      getTopic,
      getMessageOn,
      getMessageOff,
      getTopicResult,
      getResultOn,
      getResultOff,
      (a, b, c, d, e, f) => true);

  Function(String) get changeTopic => _topicController.sink.add;

  Function(String) get changeMessageOn => _messageOnController.sink.add;

  Function(String) get changeMessageOff => _messageOffController.sink.add;

  Function(String) get changeTopicResult => _topicResultController.sink.add;

  Function(String) get changeResultOn => _resultOnController.sink.add;

  Function(String) get changeResultOff => _resultOffController.sink.add;

  Function(bool) get changeStatus => _statusController.sink.add;
}

class SwitchPluginManagerProvider extends SwitchPluginManager {
  SwitchPluginManagerProvider(SQFLitePluginsRepository pluginsRepository,
      DeviceModel device, PluginModel plugin)
      : super(pluginsRepository, device, plugin) {
    if (_currentPlugin != null) {
      _topicController.add(_currentPlugin.config['topic']);
      _messageOnController.add(_currentPlugin.config["messageOn"]);
      _messageOffController.add(_currentPlugin.config["messageOff"]);
      _statusController.add(_currentPlugin.status);
      _topicResultController.add(_currentPlugin.config["topicResult"]);
      _resultOnController.add(_currentPlugin.config["resultOn"]);
      _resultOffController.add(_currentPlugin.config["resultOff"]);
    }
  }

  Future<bool> save() async {
    try {
      _stateController.add(SavePluginState.SAVING);

      await _pluginsRepository.savePlugin(PluginModel(
          type: 'switch',
          status: _statusController.value,
          deviceId: _device.id,
          config: {
            "topic": _topicController.value,
            "messageOn": _messageOnController.value,
            "messageOff": _messageOffController.value,
            "topicResult": _topicResultController.value,
            "resultOn": _resultOnController.value,
            "resultOff": _resultOffController.value,
          }));

      message = Strings.switchSavedSuccessfully;
      _stateController.add(SavePluginState.SUCCESS);
      return true;
    } catch (e) {
      message = Strings.switchErrorSaving;
      _stateController.add(SavePluginState.FAIL);
      print('switch_plugin_manager_bloc:save() $e');
      return false;
    }
  }

  Future<bool> update() async {
    try {
      _stateController.add(SavePluginState.SAVING);
      PluginModel _updatedPlugin = PluginModel(
          id: _currentPlugin.id,
          type: 'switch',
          status: _statusController.value,
          deviceId: _currentPlugin.deviceId,
          config: {
            "topic": _topicController.value,
            "messageOn": _messageOnController.value,
            "messageOff": _messageOffController.value,
            "topicResult": _topicResultController.value,
            "resultOn": _resultOnController.value,
            "resultOff": _resultOffController.value,
          });

      await _pluginsRepository.updatePlugin(_updatedPlugin);
      _stateController.add(SavePluginState.SUCCESS);
      return true;
    } catch (e) {
      message = Strings.switchErrorUpdating;
      _stateController.add(SavePluginState.FAIL);
      print('switch_plugin_manager_bloc:update() $e');
      return false;
    }
  }
}
