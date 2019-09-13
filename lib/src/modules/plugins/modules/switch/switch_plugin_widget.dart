import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'switch_plugin_bloc.dart';

class SwitchPluginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<SwitchPluginProvider>(context);
    Color _switchColor;
    return Center(
      child: StreamBuilder<bool>(
          stream: _bloc.getSwitchStatus,
          initialData: false,
          builder: (context, snapshot) {
            if (snapshot.data) {
              _switchColor = Colors.green;
            } else {
              _switchColor = Colors.grey;
            }
            return InkWell(
              onTap: _bloc.switchPower,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _switchColor,
                  ),
                ),
                padding: EdgeInsets.all(30.0),
                child: Icon(
                  Icons.flash_on,
                  size: 40.0,
                  color: _switchColor,
                ),
              ),
            );
          }),
    );
  }
}
