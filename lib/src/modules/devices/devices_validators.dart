import 'dart:async';

class DevicesValidators {
  final validateMessage = StreamTransformer<String, String>.fromHandlers(
      handleData: (message, sink) {
    if (message.isNotEmpty) {
      sink.add(message);
    }
  });
}
