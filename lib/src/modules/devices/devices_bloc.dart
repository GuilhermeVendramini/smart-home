import 'package:flutter/foundation.dart';

import '../../repositories/hasura/devices/hasura_devices_repository.dart';
import '../../shared/models/device/device_model.dart';
import '../../shared/models/place/place_model.dart';
import 'devices_validators.dart';

enum DevicesState { LOADING, SUCCESS, FAIL }

class DevicesBloc extends ChangeNotifier with DevicesValidators {
  final HasuraDevicesRepository _devicesRepository;
  final PlaceModel _place;

  DevicesBloc(this._devicesRepository, this._place);

  List<DeviceModel> _devices;

  @override
  void dispose() async {
    super.dispose();
  }
}

class Devices extends DevicesBloc {
  Devices(HasuraDevicesRepository devicesRepository, PlaceModel place)
      : super(devicesRepository, place);

  get getPlace => _place;

  get getDevices => _devices;
}

class DevicesProvider extends Devices {
  DevicesProvider(HasuraDevicesRepository devicesRepository, PlaceModel place)
      : super(devicesRepository, place);

  Future<DevicesState> loadDevices({bool cached = true}) async {
    if (cached && _devices != null) {
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
}
