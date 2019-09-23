import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/colors/default_colors.dart';
import '../../../../shared/languages/en/strings.dart';
import '../../../../shared/models/plugin/plugin_model.dart';
import '../../modules/switch/modules/switch_plugin_manager/switch_plugin_manager_module.dart';
import '../../plugins_bloc.dart';

class SwitchType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PluginsProvider>(context);
    final _device = _bloc.getDevice;
    final Color _enabledColor = DefaultColors.green;
    final Color _disabledColor = DefaultColors.grey;
    final PluginModel _plugin = _bloc.getPluginByType("switch");
    return ListTile(
      title: Text(Strings.switchPluginTitle),
      leading: Icon(
        Icons.flash_on,
        color:
            _plugin != null && _plugin.status ? _enabledColor : _disabledColor,
      ),
      subtitle: Text(Strings.switchPluginDescription),
      trailing: const Icon(Icons.settings),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SwitchPluginManagerModule(_device, _plugin)),
        );
      },
    );
  }
}
