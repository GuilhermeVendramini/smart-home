import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_bloc.dart';
import 'app_theme.dart';
import 'modules/auth/login/login_module.dart';
import 'modules/places/places_module.dart';
import 'shared/languages/pt-br/strings.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    AppTheme.systemChrome;

    final _bloc = Provider.of<AppProvider>(context);
    if (_bloc.getUser == null) {
      _bloc.autoAuthUser();
    }
    return MaterialApp(
      title: Strings.devicesTitle,
      theme: AppTheme.themeData,
      home: StreamBuilder<LoginState>(
          stream: _bloc.getLoginState,
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
