import 'dart:async';

class PlacesManagerValidators {
  final validateName =
      StreamTransformer<String, String>.fromHandlers(handleData: (name, sink) {
    if (name.isNotEmpty) {
      sink.add(name);
    } else {
      sink.addError("Name is required");
    }
  });

  final validateIcon =
      StreamTransformer<String, String>.fromHandlers(handleData: (icon, sink) {
    if (icon.isNotEmpty) {
      sink.add(icon);
    } else {
      sink.addError("Icon is required");
    }
  });
}
