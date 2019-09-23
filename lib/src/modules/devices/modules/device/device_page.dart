import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../modules/plugins/plugins_module.dart';
import '../../../../shared/models/device/device_model.dart';
import '../../../../shared/widgets/components/mqtt_status.dart';
import 'device_bloc.dart';
import 'widgets/plugins_load.dart';

class DevicePage extends StatefulWidget {
  @override
  _DevicePageState createState() => _DevicePageState();
}

class _DevicePageState extends State<DevicePage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DeviceProvider>(context);
    final DeviceModel _device = _bloc.getDevice;
    return Scaffold(
      appBar: AppBar(
        title: Text(_device.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          MqttStatus(),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PluginsModule(
                          _device,
                          _bloc.getPlugins,
                        )),
              );
            },
          ),
        ],
      ),
      body: PluginsLoad(),
    );
  }
}
