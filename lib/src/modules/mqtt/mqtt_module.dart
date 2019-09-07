import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_bloc.dart';
import 'mqtt_bloc.dart';
import 'mqtt_page.dart';

class MqttModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AppProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MqttProvider>(
            builder: (_) => MqttProvider(
                  _bloc,
                )),
      ],
      child: MqttPage(),
    );
  }
}
