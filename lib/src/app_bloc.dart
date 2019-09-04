import 'package:flutter/foundation.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared/models/user/user_model.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class AppBloc with ChangeNotifier {
  UserModel _user;
  final _stateController = BehaviorSubject<LoginState>();

  @override
  void dispose() {
    _stateController.close();
    super.dispose();
  }
}

class App extends AppBloc {
  UserModel get getUser {
    return _user;
  }

  Stream<LoginState> get streamState => _stateController.stream;
}

class AppProvider extends App {
  Future<Null> cleanUser() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _user = null;
    _prefs.remove('name');
    _prefs.remove('id');
    _stateController.add(LoginState.IDLE);
  }

  Future<bool> userIsLogged() async {
    _stateController.add(LoginState.LOADING);
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    try {
      if (_prefs.getString('name') != null &&
          _prefs.getString('name').isNotEmpty) {
        _user = UserModel(
          id: _prefs.getInt('id'),
          name: _prefs.getString('name'),
        );
        _stateController.add(LoginState.SUCCESS);
        return true;
      }
      _stateController.add(LoginState.IDLE);
      return false;
    } catch (e) {
      print('app_bloc:userIsLogged() $e');
      _stateController.add(LoginState.FAIL);
      return false;
    }
  }

  Future<Null> setUser(UserModel user) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    _user = user;
    _prefs.setString('name', user.name);
    _prefs.setInt('id', user.id);
    _stateController.add(LoginState.SUCCESS);
  }
}
