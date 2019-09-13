import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../modules/devices/modules/device/device_module.dart';
import '../../../../../../../shared/languages/pt-br/strings.dart';
import '../switch_plugin_manager_bloc.dart';

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<SwitchPluginManagerProvider>(context);
    void _submit() async {
      bool result = await _bloc.save();
      if (!result) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_bloc.message),
            duration: Duration(seconds: 3),
          ),
        );
      } else {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DeviceModule(_bloc.getDevice)),
        );
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
