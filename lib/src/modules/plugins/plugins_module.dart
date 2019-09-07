import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'plugins_bloc.dart';
import 'plugins_page.dart';

class PluginsModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PluginsProvider>(
            builder: (_) => PluginsProvider()),
      ],
      child: PluginsPage(),
    );
  }
}
