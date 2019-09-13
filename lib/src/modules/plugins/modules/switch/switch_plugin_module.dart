import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app_bloc.dart';
import '../../../../shared/models/plugin/plugin_model.dart';
import 'switch_plugin_bloc.dart';
import 'switch_plugin_widget.dart';

class SwitchPluginModule extends StatelessWidget {
  final PluginModel _plugin;

  SwitchPluginModule(this._plugin);

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AppProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SwitchPluginProvider>(
            builder: (_) => SwitchPluginProvider(
                  _plugin,
                  _bloc,
                )),
      ],
      child: SwitchPluginWidget(),
    );
  }
}
