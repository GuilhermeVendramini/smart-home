import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../src/shared/languages/pt-br/strings.dart';
import '../modules/switch/switch_plugin_module.dart';
import '../plugins_bloc.dart';

class PluginsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PluginsProvider>(context);
    final _device = _bloc.getDevice;
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(Strings.switchPluginTitle),
          leading: const Icon(
            Icons.flash_on,
            color: Colors.green,
          ),
          subtitle: Text(Strings.switchPluginDescription),
          trailing: const Icon(Icons.settings),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SwitchPluginModule(_device)),
            );
          },
        ),
        ListTile(
          title: Text(Strings.sliderPluginTitle),
          leading: const Icon(
            Icons.linear_scale,
          ),
          subtitle: Text(Strings.sliderPluginDescription),
          trailing: const Icon(Icons.settings),
          onTap: () {},
        ),
      ],
    );
  }
}
