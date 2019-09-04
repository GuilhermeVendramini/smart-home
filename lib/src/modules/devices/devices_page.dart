import 'package:flutter/material.dart';

import '../../../src/shared/languages/pt-br/strings.dart';
import '../../../src/shared/widgets/components/side_drawer.dart';
//import 'devices_bloc.dart';

class DevicesPage extends StatefulWidget {
  @override
  _DevicesPageState createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  @override
  Widget build(BuildContext context) {
    //final _bloc = Provider.of<DevicesProvider>(context);
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Strings.appName),
      ),
      body: Text('My Devices'),
    );
  }
}
