import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../src/shared/languages/pt-br/strings.dart';
import '../../../src/shared/widgets/fields/stream_input_field.dart';
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
        title: Text(Strings.login),
      ),
      body: StreamBuilder<LoginState>(
        stream: _bloc.streamState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == LoginState.LOADING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputField(
                hint: Strings.userName,
                obscure: false,
                stream: _bloc.streamName,
                onChanged: _bloc.changeName,
              ),
              StreamInputField(
                hint: Strings.userPassword,
                obscure: true,
                stream: _bloc.streamPassword,
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
