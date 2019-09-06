import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../repositories/hasura/devices/hasura_devices_repository.dart';
import '../../../../shared/languages/pt-br/strings.dart';
import '../../../../shared/models/device/device_model.dart';
import '../../devices_bloc.dart';
import 'devices_manager_validators.dart';

enum DevicesManagerState { LOADING, SUCCESS, FAIL }

class DevicesManagerBloc extends ChangeNotifier with DevicesManagerValidators {
  final DevicesProvider _devicesProvider;
  final HasuraDevicesRepository _devicesRepository;

  DevicesManagerBloc(this._devicesProvider, this._devicesRepository);

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
  DevicesManager(DevicesProvider devicesProvider,
      HasuraDevicesRepository devicesRepository)
      : super(devicesProvider, devicesRepository);

  Stream<String> get getName => _nameController.stream.transform(validateName);

  Stream<String> get getIcon => _iconController.stream.transform(validateIcon);

  Stream<DevicesManagerState> get streamState => _stateController.stream;

  Function(String) get changeName => _nameController.sink.add;

  set setIcon(String icon) {
    _iconController.sink.add(icon);
  }

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(getName, getIcon, (a, b) => true);
}

class DevicesManagerProvider extends DevicesManager {
  DevicesManagerProvider(DevicesProvider devicesProvider,
      HasuraDevicesRepository devicesRepository)
      : super(devicesProvider, devicesRepository);

  Future<DeviceModel> addDevice() async {
    try {
      _stateController.add(DevicesManagerState.LOADING);
      DeviceModel _device;

      _device = await _devicesRepository.createDevice(
        name: _nameController.value,
        icon: _iconController.value,
        placeId: _devicesProvider.getPlace.id,
      );

      message = Strings.devicesSavedSuccessfully;
      _devicesProvider.addDevice(_device);
      _stateController.add(DevicesManagerState.SUCCESS);
      return _device;
    } catch (e) {
      print('devices_bloc:addDevice() $e');
      _stateController.add(DevicesManagerState.FAIL);
      message = Strings.devicesErrorSaving;
      return null;
    }
  }
}
