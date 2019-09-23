import 'dart:async';

import '../../../../shared/languages/en/strings.dart';

class DevicesManagerValidators {
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError(Strings.devicesRequiredName);
    }
  });

  final validateIcon =
      StreamTransformer<String, String>.fromHandlers(handleData: (icon, sink) {
    if (icon.isNotEmpty) {
      sink.add(icon);
    } else {
      sink.addError(Strings.icon);
    }
  });
}
