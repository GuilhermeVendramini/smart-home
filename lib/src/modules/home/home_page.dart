import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';

import '../../../src/shared/widgets/components/side_drawer.dart';
import '../../../src/shared/languages/pt-br/strings.dart';
//import 'home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    //final _bloc = Provider.of<HomeProvider>(context);
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Strings.appName),
      ),
      body: Text('My Home'),
    );
  }
}
