import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/languages/pt-br/strings.dart';
import '../../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'register_bloc.dart';
import 'widgets/register_button.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<RegisterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.authRegister),
      ),
      body: StreamBuilder<RegisterState>(
        stream: _bloc.getState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == RegisterState.LOADING
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
              RegisterButton(),
            ],
          );
        },
      ),
    );
  }
}
