import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'mqtt_bloc.dart';
import 'mqtt_page.dart';

class MqttModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MqttProvider>(builder: (_) => MqttProvider()),
      ],
      child: MqttPage(),
    );
  }
}
