import 'package:flutter/material.dart';
import '../modules/switch/switch_plugin_module.dart';

import '../../../../src/shared/languages/pt-br/strings.dart';

class PluginsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text(Strings.switchPluginTitle),
          leading: const Icon(Icons.flash_on, color: Colors.green,),
          subtitle: Text(Strings.switchPluginDescription),
          trailing: const Icon(Icons.settings),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SwitchPluginModule()),
            );
          },
        ),
        ListTile(
          title: Text(Strings.sliderPluginTitle),
          leading: const Icon(Icons.linear_scale,),
          subtitle: Text(Strings.sliderPluginDescription),
          trailing: const Icon(Icons.settings),
          onTap: () {},
        ),
      ],
    );
  }
}
