import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/sqflite/devices/sqflite_devices_repository.dart';
import '../../shared/models/place/place_model.dart';
import 'devices_bloc.dart';
import 'devices_page.dart';

class DevicesModule extends StatelessWidget {
  final PlaceModel _place;

  DevicesModule(this._place);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicesProvider>(
            builder: (_) => DevicesProvider(
                  SQFLiteDevicesRepository(),
                  _place,
                )),
      ],
      child: DevicesPage(),
    );
  }
}
