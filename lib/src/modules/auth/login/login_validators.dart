import 'dart:async';

import '../../../shared/languages/pt-br/strings.dart';

class LoginValidators {
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError(Strings.authRequiredName);
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isNotEmpty) {
      sink.add(password);
    } else {
      sink.addError(Strings.authRequiredPassword);
    }
  });
}
