import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'switch_plugin_bloc.dart';
import 'switch_plugin_page.dart';

class SwitchPluginModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SwitchPluginProvider>(
            builder: (_) => SwitchPluginProvider()),
      ],
      child: SwitchPluginPage(),
    );
  }
}
