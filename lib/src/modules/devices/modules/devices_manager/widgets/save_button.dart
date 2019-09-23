import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../modules/devices/modules/device/device_module.dart';
import '../../../../../shared/models/device/device_model.dart';
import '../../../devices_module.dart';
import '../devices_manager_bloc.dart';

class DevicesSaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesManagerProvider>(context);
    final DeviceModel _currentDevice = _bloc.getCurrentDevice;
    void _submit() async {
      DeviceModel _device = _currentDevice == null
          ? await _bloc.addDevice()
          : await _bloc.updateDevice();

      if (_device == null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_bloc.message),
            duration: Duration(seconds: 3),
          ),
        );
      }
      if (_device != null && _currentDevice == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DeviceModule(
              _device,
            ),
          ),
        );
      }
      if (_device != null && _currentDevice != null) {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DevicesModule(
              _bloc.getCurrentPlace,
            ),
          ),
        );
      }
    }

    return StreamBuilder<bool>(
      stream: _bloc.outSubmitValid,
      builder: (context, snapshot) {
        return FloatingActionButton(
          heroTag: 'save',
          child: Icon(Icons.check),
          backgroundColor: snapshot.hasData
              ? Theme.of(context).floatingActionButtonTheme.backgroundColor
              : Theme.of(context).disabledColor,
          onPressed: snapshot.hasData ? _submit : null,
        );
      },
    );
  }
}
