import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/models/device/device_model.dart';
import 'plugins_bloc.dart';
import 'plugins_page.dart';

class PluginsModule extends StatelessWidget {
  final DeviceModel _device;

  PluginsModule(this._device);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PluginsProvider>(
            builder: (_) => PluginsProvider(
                  _device,
                )),
      ],
      child: PluginsPage(),
    );
  }
}
