import 'package:flutter/foundation.dart';

import '../../repositories/sqflite/devices/sqflite_devices_repository.dart';
import '../../shared/models/device/device_model.dart';
import '../../shared/models/place/place_model.dart';
import 'devices_validators.dart';

enum DevicesState { LOADING, SUCCESS, FAIL }

class DevicesBloc extends ChangeNotifier with DevicesValidators {
  final SQFLiteDevicesRepository _devicesRepository;
  final PlaceModel _place;

  DevicesBloc(this._devicesRepository, this._place);

  List<DeviceModel> _devices = [];

  @override
  void dispose() async {
    super.dispose();
  }
}

class Devices extends DevicesBloc {
  Devices(SQFLiteDevicesRepository devicesRepository, PlaceModel place)
      : super(devicesRepository, place);

  PlaceModel get getPlace => _place;

  List<DeviceModel> get getDevices => _devices;
}

class DevicesProvider extends Devices {
  DevicesProvider(SQFLiteDevicesRepository devicesRepository, PlaceModel place)
      : super(devicesRepository, place);

  Future<DevicesState> loadDevices({bool cached = true}) async {
    if (cached && _devices.isNotEmpty) {
      return DevicesState.SUCCESS;
    }

    try {
      List<DeviceModel> _devicesResult = List<DeviceModel>();
      _devicesResult = await _devicesRepository.getDevices(placeId: _place.id);
      if (_devicesResult.isEmpty) {
        return DevicesState.SUCCESS;
      }

      _devices = _devicesResult;
      return DevicesState.SUCCESS;
    } catch (e) {
      print('devices_bloc:loadDevices() $e');
      return DevicesState.FAIL;
    }
  }

  bool addDevice(DeviceModel device) {
    try {
      _devices.add(device);
      return true;
    } catch (e) {
      print('devices_bloc:addDevice() $e');
      return false;
    }
  }
}
