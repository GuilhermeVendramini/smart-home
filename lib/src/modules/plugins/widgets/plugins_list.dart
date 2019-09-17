import 'package:flutter/material.dart';

import 'types/switch_type.dart';

class PluginsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        SwitchType(),
      ],
    );
  }
}
