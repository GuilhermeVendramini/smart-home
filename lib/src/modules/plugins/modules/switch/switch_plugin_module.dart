import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../src/shared/models/device/device_model.dart';
import '../../../../../src/repositories/hasura/plugins/hasura_plugins_repository.dart';

import 'switch_plugin_bloc.dart';
import 'switch_plugin_page.dart';

class SwitchPluginModule extends StatelessWidget {
  final DeviceModel _device;

  SwitchPluginModule(this._device);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SwitchPluginProvider>(
            builder: (_) => SwitchPluginProvider(
                HasuraPluginsRepository(),
              _device,
            )),
      ],
      child: SwitchPluginPage(),
    );
  }
}
