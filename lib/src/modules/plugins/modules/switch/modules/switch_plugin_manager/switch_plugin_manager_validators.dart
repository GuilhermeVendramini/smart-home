import 'dart:async';

import '../../../../../../shared/languages/en/strings.dart';

class SwitchPluginManagerValidators {
  final validateTopic =
      StreamTransformer<String, String>.fromHandlers(handleData: (topic, sink) {
    if (topic.isNotEmpty) {
      sink.add(topic);
    } else {
      sink.addError(Strings.switchPluginRequiredTopic);
    }
  });

  final validateMessageOn = StreamTransformer<String, String>.fromHandlers(
      handleData: (messageOn, sink) {
    if (messageOn.isNotEmpty) {
      sink.add(messageOn);
    } else {
      sink.addError(Strings.switchPluginRequiredMessageOn);
    }
  });

  final validateMessageOff = StreamTransformer<String, String>.fromHandlers(
      handleData: (messageOff, sink) {
    if (messageOff.isNotEmpty) {
      sink.add(messageOff);
    } else {
      sink.addError(Strings.switchPluginRequiredMessageOff);
    }
  });

  final validateTopicResult =
      StreamTransformer<String, String>.fromHandlers(handleData: (topic, sink) {
    if (topic.isNotEmpty) {
      sink.add(topic);
    } else {
      sink.addError(Strings.switchPluginRequiredTopicResult);
    }
  });

  final validateResultOn = StreamTransformer<String, String>.fromHandlers(
      handleData: (messageOn, sink) {
    if (messageOn.isNotEmpty) {
      sink.add(messageOn);
    } else {
      sink.addError(Strings.switchPluginRequiredResultOn);
    }
  });

  final validateResultOff = StreamTransformer<String, String>.fromHandlers(
      handleData: (messageOff, sink) {
    if (messageOff.isNotEmpty) {
      sink.add(messageOff);
    } else {
      sink.addError(Strings.switchPluginRequiredResultOff);
    }
  });
}
