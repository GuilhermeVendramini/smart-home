import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/models/device/device_model.dart';
import '../devices_manager_bloc.dart';
import 'delete_button.dart';
import 'save_button.dart';

class DevicesFloatingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesManagerProvider>(context);
    final DeviceModel _currentPlace = _bloc.getCurrentDevice;

    if (_currentPlace != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DevicesDeleteButton(),
          DevicesSaveButton(),
        ],
      );
    }

    return DevicesSaveButton();
  }
}
