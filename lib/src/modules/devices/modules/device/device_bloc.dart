import 'package:flutter/foundation.dart';

import '../../../../repositories/hasura/plugins/hasura_plugins_repository.dart';
import '../../../../shared/models/device/device_model.dart';
import '../../../../shared/models/plugin/plugin_model.dart';

enum PluginsState { LOADING, SUCCESS, FAIL }

class DeviceBloc extends ChangeNotifier {
  final HasuraPluginsRepository _pluginsRepository;
  final DeviceModel _device;

  DeviceBloc(this._pluginsRepository, this._device);

  List<PluginModel> _plugins = [];

  @override
  void dispose() async {
    super.dispose();
  }
}

class Device extends DeviceBloc {
  Device(HasuraPluginsRepository pluginsRepository, DeviceModel device)
      : super(pluginsRepository, device);

  DeviceModel get getDevice => _device;

  List<PluginModel> get getPlugins {
    return _plugins;
  }

  List<PluginModel> get getEnabledPlugins {
    return _plugins.where((plugin) => plugin.status == true).toList();
  }
}

class DeviceProvider extends Device {
  DeviceProvider(HasuraPluginsRepository pluginsRepository, DeviceModel device)
      : super(pluginsRepository, device);

  Future<PluginsState> loadPlugins({bool cached = true}) async {
    if (cached && _plugins.isNotEmpty) {
      return PluginsState.SUCCESS;
    }

    try {
      List<PluginModel> _pluginsResult = List<PluginModel>();
      _pluginsResult =
          await _pluginsRepository.getPlugins(deviceId: _device.id);
      if (_pluginsResult.isEmpty) {
        return PluginsState.SUCCESS;
      }
      _plugins = _pluginsResult;
      return PluginsState.SUCCESS;
    } catch (e) {
      print('device_bloc:loadPlugins() $e');
      return PluginsState.FAIL;
    }
  }
}
