import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'switch_plugin_bloc.dart';

class SwitchPluginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<SwitchPluginProvider>(context);
    final Color _colorOff = Colors.grey;
    return Center(
      child: InkWell(
        onTap: _bloc.switchPower,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: _colorOff,
            ),
          ),
          padding: EdgeInsets.all(30.0),
          child: Icon(
            Icons.flash_on,
            size: 40.0,
            color: _colorOff,
          ),
        ),
      ),
    );
  }
}
