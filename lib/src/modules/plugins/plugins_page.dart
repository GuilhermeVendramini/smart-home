import 'package:flutter/material.dart';

import '../../shared/languages/en/strings.dart';
import 'widgets/plugins_list.dart';

class PluginsPage extends StatefulWidget {
  @override
  _PluginsPageState createState() => _PluginsPageState();
}

class _PluginsPageState extends State<PluginsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
