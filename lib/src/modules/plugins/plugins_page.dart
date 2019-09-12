import 'package:flutter/material.dart';

import '../../shared/languages/pt-br/strings.dart';
import '../../shared/widgets/components/side_drawer.dart';
import 'widgets/plugins_list.dart';

class PluginsPage extends StatefulWidget {
  @override
  _PluginsPageState createState() => _PluginsPageState();
}

class _PluginsPageState extends State<PluginsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Strings.pluginsTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: PluginsList(),
    );
  }
}
