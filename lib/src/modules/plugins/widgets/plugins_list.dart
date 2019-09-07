import 'package:flutter/material.dart';

class PluginsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        CheckboxListTile(
          title: Text('ON/OFF'),
          value: true,
          onChanged: (bool value) {},
          secondary: const Icon(Icons.flash_on),
        ),
        CheckboxListTile(
          title: Text('Slider'),
          value: true,
          onChanged: (bool value) {},
          secondary: const Icon(Icons.linear_scale),
        )
      ],
    );
  }
}
