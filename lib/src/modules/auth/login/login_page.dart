import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/languages/pt-br/strings.dart';
import '../../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'login_bloc.dart';
import 'widgets/login_button.dart';
//import 'widgets/register_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.authLogin),
      ),
      body: StreamBuilder<LoginState>(
        stream: _bloc.getState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == LoginState.LOADING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputTextField(
                hint: Strings.authName,
                obscure: false,
                stream: _bloc.getName,
                onChanged: _bloc.changeName,
              ),
              StreamInputTextField(
                hint: Strings.authPassword,
                obscure: true,
                stream: _bloc.getPassword,
                onChanged: _bloc.changePassword,
              ),
              LoginButton(),
              //RegisterButton(),
            ],
          );
        },
      ),
    );
  }
}
