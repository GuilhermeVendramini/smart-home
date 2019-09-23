import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/models/place/place_model.dart';
import '../../shared/widgets/components/mqtt_status.dart';
import 'devices_bloc.dart';
import 'widgets/devices_load.dart';

class DevicesPage extends StatefulWidget {
  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesProvider>(context);
    final PlaceModel _place = _bloc.getPlace;
    return Scaffold(
      appBar: AppBar(
        title: Text(_place.name),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          MqttStatus(),
        ],
      ),
      body: DevicesLoad(),
    );
  }
}
