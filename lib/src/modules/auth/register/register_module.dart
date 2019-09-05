import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './../register/register_bloc.dart';
import './../register/register_page.dart';
import '../../../app_bloc.dart';
import '../../../repositories/hasura/users/hasura_users_repository.dart';

class RegisterModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AppProvider>(context);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RegisterProvider>(
            builder: (_) => RegisterProvider(
                  HasuraUsersRepository(),
                  _bloc,
                )),
      ],
      child: RegisterPage(),
    );
  }
}
