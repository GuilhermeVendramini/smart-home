import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/sqflite/plugins/sqflite_plugins_repository.dart';
import '../../../../shared/models/device/device_model.dart';
import 'device_bloc.dart';
import 'device_page.dart';

class DeviceModule extends StatelessWidget {
  final DeviceModel _device;

  DeviceModule(this._device);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DeviceProvider>(
            builder: (_) => DeviceProvider(
                  SQFLitePluginsRepository(),
                  _device,
                )),
      ],
      child: DevicePage(),
    );
  }
}
