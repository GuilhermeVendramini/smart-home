import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../modules/plugins/modules/switch/switch_plugin_module.dart';
import '../device_bloc.dart';

class PluginsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DeviceProvider>(context);
    final _plugins = _bloc.getPlugins;
    return ListView.builder(
      padding: EdgeInsets.all(20.0),
      itemCount: _plugins.length,
      itemBuilder: (BuildContext context, int index) {
        switch (_plugins[index].type) {
          case 'switch':
            {
              return SwitchPluginModule(_plugins[index]);
            }
            break;

          default:
            {
              return Container();
            }
        }
      },
    );
  }
}
