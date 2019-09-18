import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modules/devices/modules/device/device_module.dart';
import '../../../modules/devices/modules/devices_manager/devices_manager_module.dart';
import '../../../shared/models/device/device_model.dart';
import '../devices_bloc.dart';

class DevicesCard extends StatelessWidget {
  final DeviceModel _device;

  DevicesCard(this._device);

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesProvider>(context);
    return InkWell(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DevicesManagerModule(
              _bloc,
              _device,
            ),
          ),
        );
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeviceModule(
                    _device,
                  )),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconData(_device.icon, fontFamily: 'SmartHomeDevicesIcons'),
              size: 40.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _device.name,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
