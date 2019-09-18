import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modules/devices/modules/devices_manager/devices_manager_module.dart';
import '../devices_bloc.dart';

class DevicesCardAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DevicesManagerModule(_bloc, null),
          ),
        );
      },
      child: Card(
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }
}
