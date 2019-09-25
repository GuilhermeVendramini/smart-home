import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../repositories/sqflite/devices/sqflite_devices_repository.dart';
import '../../../../shared/languages/en/strings.dart';
import '../../../../shared/models/device/device_model.dart';
import '../../../../shared/models/place/place_model.dart';
import '../../devices_bloc.dart';
import 'devices_manager_validators.dart';

enum DevicesManagerState { LOADING, SUCCESS, FAIL }

class DevicesManagerBloc extends ChangeNotifier with DevicesManagerValidators {
  final DevicesProvider _devicesProvider;
  final SQFLiteDevicesRepository _devicesRepository;
  final DeviceModel _currentDevice;

  DevicesManagerBloc(
      this._devicesProvider, this._currentDevice, this._devicesRepository);

  final _nameController = BehaviorSubject<String>();
  final _iconController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<DevicesManagerState>();
  String message;

  @override
  void dispose() async {
    _nameController.close();
    _iconController.close();
    _stateController.close();
    super.dispose();
  }
}

class DevicesManager extends DevicesManagerBloc {
  DevicesManager(DevicesProvider devicesProvider, DeviceModel currentDevice,
      SQFLiteDevicesRepository devicesRepository)
      : super(devicesProvider, currentDevice, devicesRepository);

  Stream<String> get getName => _nameController.stream.transform(validateName);

  Stream<String> get getIcon => _iconController.stream.transform(validateIcon);

  Stream<DevicesManagerState> get streamState => _stateController.stream;

  Function(String) get changeName => _nameController.sink.add;

  DeviceModel get getCurrentDevice => _currentDevice;

  PlaceModel get getCurrentPlace => _devicesProvider.getPlace;

  set setIcon(String icon) {
    _iconController.sink.add(icon);
  }

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(getName, getIcon, (a, b) => true);
}

class DevicesManagerProvider extends DevicesManager {
  DevicesManagerProvider(DevicesProvider devicesProvider,
      DeviceModel currentDevice, SQFLiteDevicesRepository devicesRepository)
      : super(devicesProvider, currentDevice, devicesRepository) {
    if (currentDevice != null) {
      _nameController.add(_currentDevice.name);
    }
  }

  Future<DeviceModel> addDevice() async {
    try {
      _stateController.add(DevicesManagerState.LOADING);
      DeviceModel _device;

      _device = await _devicesRepository.createDevice(DeviceModel(
        name: _nameController.value,
        icon: int.tryParse(_iconController.value),
        placeId: _devicesProvider.getPlace.id,
      ));

      _devicesProvider.addDevice(_device);
      _stateController.add(DevicesManagerState.SUCCESS);
      return _device;
    } catch (e) {
      print('devices_manager_bloc:addDevice() $e');
      _stateController.add(DevicesManagerState.FAIL);
      message = Strings.devicesErrorSaving;
      return null;
    }
  }

  Future<DeviceModel> updateDevice() async {
    try {
      _stateController.add(DevicesManagerState.LOADING);
      DeviceModel _device;

      _device = await _devicesRepository.updateDevice(DeviceModel(
        id: _currentDevice.id,
        name: _nameController.value,
        icon: int.tryParse(_iconController.value),
        placeId: _devicesProvider.getPlace.id,
      ));

      _stateController.add(DevicesManagerState.SUCCESS);
      return _device;
    } catch (e) {
      print('devices_manager_bloc:updateDevice() $e');
      _stateController.add(DevicesManagerState.FAIL);
      message = Strings.devicesErrorUpdating;
      return null;
    }
  }

  Future<bool> deleteDevice() async {
    try {
      _stateController.add(DevicesManagerState.LOADING);
      bool _result;

      _result = await _devicesRepository.deleteDevice(_currentDevice.id);

      _stateController.add(DevicesManagerState.SUCCESS);
      return _result;
    } catch (e) {
      print('devices_manager_bloc:deleteDevice() $e');
      _stateController.add(DevicesManagerState.FAIL);
      message = Strings.devicesErrorDeleting;
      return false;
    }
  }
}
