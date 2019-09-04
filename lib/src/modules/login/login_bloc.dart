import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../app_bloc.dart';
import '../../repositories/hasura/users/hasura_users_repository.dart';
import '../../shared/languages/pt-br/strings.dart';
import '../../shared/models/user/user_model.dart';
import 'login_validators.dart';

enum LoginState { IDLE, LOADING, SUCCESS, FAIL }

class LoginBloc extends ChangeNotifier with LoginValidators {
  final HasuraUsersRepository _usersRepository;
  final AppProvider _appBloc;

  LoginBloc(this._usersRepository, this._appBloc);

  final BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  final BehaviorSubject<String> _passwordController = BehaviorSubject<String>();
  final BehaviorSubject<LoginState> _stateController = BehaviorSubject<LoginState>();

  String message;

  @override
  void dispose() {
    _nameController.close();
    _passwordController.close();
    _stateController.close();
    super.dispose();
  }
}

class Login extends LoginBloc {
  Login(HasuraUsersRepository userRepository, AppProvider appBloc)
      : super(userRepository, appBloc);

  Stream<String> get getName =>
      _nameController.stream.transform(validateName);

  Stream<String> get getPassword =>
      _passwordController.stream.transform(validatePassword);

  Stream<LoginState> get getState => _stateController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(getName, getPassword, (a, b) => true);

  Function(String) get changeName => _nameController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;
}

class LoginProvider extends Login {
  LoginProvider(HasuraUsersRepository userRepository, AppProvider appBloc)
      : super(userRepository, appBloc);

  Future<bool> login() async {
    try {
      _stateController.add(LoginState.LOADING);
      UserModel user = await _usersRepository.getUser(
        name: _nameController.value,
        password: _passwordController.value,
      );

      if (user == null) {
        message = Strings.loginMessageWarning;
        _stateController.add(LoginState.FAIL);
        return false;
      }

      await _appBloc.setUser(user);
      _stateController.add(LoginState.SUCCESS);
      return true;
    } catch (e) {
      print('login_bloc:login() $e');
      message = Strings.loginMessageError;
      _stateController.add(LoginState.FAIL);
      return false;
    }
  }
}
