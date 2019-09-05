import 'package:flutter/material.dart';

import '../../../../shared/languages/pt-br/strings.dart';
import '../../register/register_module.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(Strings.authRegister),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterModule()),
        );
      },
    );
  }
}
