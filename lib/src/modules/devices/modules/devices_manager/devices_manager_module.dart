import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/hasura/devices/hasura_devices_repository.dart';
import '../../devices_bloc.dart';
import 'devices_manager_bloc.dart';
import 'devices_manager_page.dart';

class DevicesManagerModule extends StatelessWidget {
  final DevicesProvider _devicesProvider;

  DevicesManagerModule(this._devicesProvider);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicesManagerProvider>(
            builder: (_) => DevicesManagerProvider(
                  _devicesProvider,
                  HasuraDevicesRepository(),
                )),
      ],
      child: DevicesManagerPage(),
    );
  }
}
