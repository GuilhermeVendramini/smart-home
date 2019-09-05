import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../../app_bloc.dart';
import 'devices_bloc.dart';
import 'devices_page.dart';

class DevicesModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final _bloc = Provider.of<AppProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DevicesProvider>(
            builder: (_) => DevicesProvider(
                  //_bloc,
                )),
      ],
      child: DevicesPage(),
    );
  }
}
