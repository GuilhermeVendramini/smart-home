import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../repositories/sqflite/plugins/sqflite_plugins_repository.dart';
import '../../../../../../shared/models/device/device_model.dart';
import '../../../../../../shared/models/plugin/plugin_model.dart';
import 'switch_plugin_manager_bloc.dart';
import 'switch_plugin_manager_page.dart';

class SwitchPluginManagerModule extends StatelessWidget {
  final DeviceModel _device;
  final PluginModel _plugin;

  SwitchPluginManagerModule(this._device, this._plugin);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SwitchPluginManagerProvider>(
            builder: (_) => SwitchPluginManagerProvider(
                  SQFLitePluginsRepository(),
                  _device,
                  _plugin,
                )),
      ],
      child: SwitchPluginManagerPage(_plugin),
    );
  }
}
