import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../devices_bloc.dart';
import 'devices_card.dart';
import 'devices_card_add.dart';

class DevicesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesProvider>(context);
    final _devices = _bloc.getDevices;
    return GridView.builder(
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _devices != null ? _devices.length + 1 : 1,
        itemBuilder: (context, index) {
          if (_devices == null || index == _devices.length) {
            return DevicesCardAdd();
          }
          return DevicesCard(_devices[index]);
        });
  }
}
