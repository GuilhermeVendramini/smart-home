import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/languages/pt-br/strings.dart';
import '../device_bloc.dart';
import 'plugins_list.dart';

class PluginsLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DeviceProvider>(context);
    print('ooowwwwwwwwww');
    return FutureBuilder<PluginsState>(
      future: _bloc.loadPlugins(),
      initialData: PluginsState.LOADING,
      builder: (BuildContext context, AsyncSnapshot<PluginsState> snapshot) {
        switch (snapshot.data) {
          case PluginsState.LOADING:
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            break;
          case PluginsState.FAIL:
            {
              return Text(Strings.pluginsLoadingMessageError);
            }
            break;
          case PluginsState.SUCCESS:
            {
              return PluginsList();
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
