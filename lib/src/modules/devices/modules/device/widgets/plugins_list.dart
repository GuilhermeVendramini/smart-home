import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../device_bloc.dart';

class PluginsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DeviceProvider>(context);
    final _plugins = _bloc.getPlugins;
    return ListView.builder(
      itemCount: _plugins.length,
      itemBuilder: (BuildContext context, int index) {
        return Text(_plugins[index].type);
      },
    );
  }
}
