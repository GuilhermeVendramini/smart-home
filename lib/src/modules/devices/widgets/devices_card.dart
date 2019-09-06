import 'package:flutter/material.dart';

import '../../../shared/models/device/device_model.dart';

class DevicesCard extends StatelessWidget {
  final DeviceModel _device;

  DevicesCard(this._device);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconData(int.tryParse(_device.icon),
                  fontFamily: 'SmartHomeDevicesIcons'),
            ),
            Text(_device.name),
          ],
        ),
      ),
    );
  }
}
