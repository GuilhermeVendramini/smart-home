import 'package:flutter/foundation.dart';

import '../../shared/models/device/device_model.dart';

class PluginsBloc extends ChangeNotifier {
  final DeviceModel _device;

  PluginsBloc(this._device);

  @override
  void dispose() async {
    super.dispose();
  }
}

class Plugins extends PluginsBloc {
  Plugins(DeviceModel device) : super(device);

  DeviceModel get getDevice {
    return _device;
  }
}

class PluginsProvider extends Plugins {
  PluginsProvider(DeviceModel device) : super(device);
}
