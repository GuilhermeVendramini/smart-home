import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/languages/pt-br/strings.dart';
import '../switch_plugin_bloc.dart';

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<SwitchPluginProvider>(context);
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
