import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_bloc.dart';

class MqttStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AppProvider>(context);
    return StreamBuilder<bool>(
        initialData: false,
        stream: _bloc.getMqttConnectionStatus,
        builder: (context, snapshot) {
          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(snapshot.data ? Icons.cloud : Icons.cloud_off),
          );
        });
  }
}
