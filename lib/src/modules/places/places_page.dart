import 'package:flutter/material.dart';

import '../../shared/languages/pt-br/strings.dart';
import '../../shared/widgets/components/mqttStatus.dart';
import '../../shared/widgets/components/side_drawer.dart';
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
      drawer: SideDrawer(),
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
