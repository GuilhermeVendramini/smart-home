import 'package:flutter/foundation.dart';
import 'package:smart_home/src/shared/models/device/device_model.dart';

enum DeviceState { LOADING, SUCCESS, FAIL }

class DeviceBloc extends ChangeNotifier {
  final DeviceModel _device;

  DeviceBloc(this._device);

  @override
  void dispose() async {
    super.dispose();
  }
}

class Device extends DeviceBloc {
  Device(DeviceModel device) : super(device);

  DeviceModel get getDevice => _device;
}

class DeviceProvider extends Device {
  DeviceProvider(DeviceModel device) : super(device);
}
