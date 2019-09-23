import 'dart:async';

import '../../shared/languages/en/strings.dart';

class MqttValidators {
  final validateBroker =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError(Strings.mqttRequiredBroker);
    }
  });

  final validateClientIdentifier =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError(Strings.mqttRequiredClientIdentifier);
    }
  });

  final validateMqttUser =
      StreamTransformer<String, String>.fromHandlers(handleData: (user, sink) {
    if (user.isNotEmpty) {
      sink.add(user);
    } else {
      sink.addError(Strings.mqttRequiredUser);
    }
  });

  final validateMqttPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.isNotEmpty) {
      sink.add(password);
    } else {
      sink.addError(Strings.mqttRequiredPassword);
    }
  });

  final validatePort =
      StreamTransformer<String, String>.fromHandlers(handleData: (port, sink) {
    if (port.isNotEmpty) {
      sink.add(port);
    } else {
      sink.addError(Strings.mqttRequiredPort);
    }
  });
}
