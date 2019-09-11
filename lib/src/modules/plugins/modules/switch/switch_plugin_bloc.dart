import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';

enum SavePluginState { SAVING, SUCCESS, FAIL }

class SwitchPluginBloc extends ChangeNotifier {

  final _topicController = BehaviorSubject<String>();
  final _messageOnController = BehaviorSubject<String>();
  final _messageOffController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<SavePluginState>();

  @override
  void dispose() async {
    _topicController.close();
    _messageOnController.close();
    _messageOffController.close();
    _stateController.close();
    super.dispose();
  }
}

class SwitchPlugin extends SwitchPluginBloc {}

class SwitchPluginProvider extends SwitchPlugin {}