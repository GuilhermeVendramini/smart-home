import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  _device,
                )),
      ],
      child: DevicePage(),
    );
  }
}
