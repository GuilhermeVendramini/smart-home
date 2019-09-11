import 'package:flutter/material.dart';

import '../../../../../src/shared/languages/pt-br/strings.dart';
import '../../../../../src/shared/widgets/components/side_drawer.dart';

class SwitchPluginPage extends StatefulWidget {
  @override
  _SwitchPluginState createState() => _SwitchPluginState();
}

class _SwitchPluginState extends State<SwitchPluginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Strings.switchPluginTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: Text('ON OFF'),
    );
  }
}
