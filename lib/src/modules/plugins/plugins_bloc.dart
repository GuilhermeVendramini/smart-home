import 'package:flutter/foundation.dart';

import '../../shared/models/device/device_model.dart';
import '../../shared/models/plugin/plugin_model.dart';

class PluginsBloc extends ChangeNotifier {
  final DeviceModel _device;
  final List<PluginModel> _devicePlugins;

  PluginsBloc(this._device, this._devicePlugins);

  @override
  void dispose() async {
    super.dispose();
  }
}

class Plugins extends PluginsBloc {
  Plugins(DeviceModel device, List<PluginModel> devicePlugins)
      : super(device, devicePlugins);

  DeviceModel get getDevice {
    return _device;
  }

  List<PluginModel> get getDevicePlugins {
    return _devicePlugins;
  }
}

class PluginsProvider extends Plugins {
  PluginsProvider(DeviceModel device, List<PluginModel> devicePlugins)
      : super(device, devicePlugins);

  PluginModel getPluginByType(String pluginType) {
    PluginModel _result = _devicePlugins
        .firstWhere((plugin) => plugin.type == pluginType, orElse: () => null);
    if (_result != null) {
      return _result;
    }
    return null;
  }
}
