import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../mqtt_bloc.dart';

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<MqttProvider>(context);

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
        return FloatingActionButton(
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
