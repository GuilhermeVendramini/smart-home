import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../repositories/hasura/plugins/hasura_plugins_repository.dart';
import '../../../../../../shared/models/device/device_model.dart';
import 'switch_plugin_manager_bloc.dart';
import 'switch_plugin_manager_page.dart';

class SwitchPluginManagerModule extends StatelessWidget {
  final DeviceModel _device;

  SwitchPluginManagerModule(this._device);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SwitchPluginManagerProvider>(
            builder: (_) => SwitchPluginManagerProvider(
                  HasuraPluginsRepository(),
                  _device,
                )),
      ],
      child: SwitchPluginManagerPage(),
    );
  }
}
