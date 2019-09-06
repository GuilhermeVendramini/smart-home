import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/languages/pt-br/strings.dart';
import '../../../../../shared/models/device/device_model.dart';
import '../devices_manager_bloc.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesManagerProvider>(context);
    void _submit() async {
      DeviceModel _place = await _bloc.addDevice();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(_bloc.message),
          duration: Duration(seconds: 3),
        ),
      );
      if (_place != null) {
        Navigator.pop(context);
      }
    }

    return StreamBuilder<bool>(
      stream: _bloc.outSubmitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text(Strings.save),
          onPressed: snapshot.hasData ? _submit : null,
        );
      },
    );
  }
}
