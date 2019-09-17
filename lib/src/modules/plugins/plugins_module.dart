import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/models/device/device_model.dart';
import '../../shared/models/plugin/plugin_model.dart';
import 'plugins_bloc.dart';
import 'plugins_page.dart';

class PluginsModule extends StatelessWidget {
  final DeviceModel _device;
  final List<PluginModel> _devicePlugins;

  PluginsModule(this._device, this._devicePlugins);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PluginsProvider>(
            builder: (_) => PluginsProvider(
                  _device,
                  _devicePlugins,
                )),
      ],
      child: PluginsPage(),
    );
  }
}
