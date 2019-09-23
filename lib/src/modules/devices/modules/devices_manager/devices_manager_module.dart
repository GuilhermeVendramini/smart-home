import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/sqflite/devices/sqflite_devices_repository.dart';
import '../../../../shared/models/device/device_model.dart';
import '../../devices_bloc.dart';
import 'devices_manager_bloc.dart';
import 'devices_manager_page.dart';

class DevicesManagerModule extends StatelessWidget {
  final DevicesProvider _devicesProvider;
  final DeviceModel _device;

  DevicesManagerModule(this._devicesProvider, this._device);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicesManagerProvider>(
            builder: (_) => DevicesManagerProvider(
                  _devicesProvider,
                  _device,
                  SQFLiteDevicesRepository(),
                )),
      ],
      child: DevicesManagerPage(_device),
    );
  }
}
