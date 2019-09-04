import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_bloc.dart';
import 'modules/places/places_module.dart';
import 'modules/login/login_module.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AppProvider>(context);
    _bloc.userIsLogged();
    return MaterialApp(
      title: 'Devices',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<LoginState>(
          stream: _bloc.streamState,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case LoginState.LOADING:
                {
                  return CircularProgressIndicator();
                }
                break;
              case LoginState.SUCCESS:
                {
                  return PlacesModule();
                }
                break;
              case LoginState.IDLE:
              case LoginState.FAIL:
                {
                  return LoginModule();
                }
                break;
              default:
                {
                  return LoginModule();
                }
            }
          }),
    );
  }
}
