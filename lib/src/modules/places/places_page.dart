import 'package:flutter/material.dart';

import '../../shared/languages/en/strings.dart';
import '../../shared/widgets/components/mqtt_status.dart';
import '../mqtt/mqtt_module.dart';
import 'widgets/places_load.dart';

class PlacesPage extends StatefulWidget {
  @override
  _PlacesPageState createState() => _PlacesPageState();
}

class _PlacesPageState extends State<PlacesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.appName),
        actions: <Widget>[
          MqttStatus(),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MqttModule()),
              );
            },
          ),
        ],
      ),
      body: PlacesLoad(),
    );
  }
}
