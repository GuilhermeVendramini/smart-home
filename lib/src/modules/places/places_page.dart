import 'package:flutter/material.dart';

import '../../../src/shared/languages/pt-br/strings.dart';
import '../../../src/shared/widgets/components/side_drawer.dart';
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
      ),
      body: PlacesLoad(),
    );
  }
}
