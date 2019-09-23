import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/colors/default_colors.dart';
import 'switch_plugin_bloc.dart';

class SwitchPluginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<SwitchPluginProvider>(context);
    Color _switchColor;
    return StreamBuilder<bool>(
        stream: _bloc.getSwitchStatus,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data) {
            _switchColor = DefaultColors.amber;
          } else {
            _switchColor = DefaultColors.grey;
          }
          return RawMaterialButton(
            onPressed: _bloc.switchPower,
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: _switchColor,
            padding: const EdgeInsets.all(15.0),
            child: Icon(
              Icons.flash_on,
              size: 40.0,
              color: Colors.white,
            ),
          );
        });
  }
}
