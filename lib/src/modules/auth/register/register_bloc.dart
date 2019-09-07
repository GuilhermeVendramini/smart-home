import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../app_bloc.dart';
import '../../../repositories/hasura/users/hasura_users_repository.dart';
import '../../../shared/languages/pt-br/strings.dart';
import '../../../shared/models/user/user_model.dart';
import 'register_validators.dart';

enum RegisterState { LOADING, SUCCESS, FAIL }

class RegisterBloc extends ChangeNotifier with RegisterValidators {
  final HasuraUsersRepository _userRepository;
  final AppProvider _appBloc;

  RegisterBloc(this._userRepository, this._appBloc);

  final _nameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<RegisterState>();

  String message;

  @override
  void dispose() {
    _nameController.close();
    _passwordController.close();
    _stateController.close();
    super.dispose();
  }
}

class Register extends RegisterBloc {
  Register(HasuraUsersRepository userRepository, AppProvider appBloc)
      : super(userRepository, appBloc);

  Stream<String> get getName => _nameController.stream.transform(validateName);

  Stream<String> get getPassword =>
      _passwordController.stream.transform(validatePassword);

  Stream<RegisterState> get getState => _stateController.stream;

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(getName, getPassword, (a, b) => true);

  Function(String) get changeName => _nameController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;
}

class RegisterProvider extends Register {
  RegisterProvider(HasuraUsersRepository userRepository, AppProvider appBloc)
      : super(userRepository, appBloc);

  Future<bool> register() async {
    try {
      _stateController.add(RegisterState.LOADING);
      UserModel _user = await _userRepository.getUser(
        name: _nameController.value,
      );

      if (_user != null) {
        _stateController.add(RegisterState.FAIL);
        message = Strings.authUserAlreadyExists;
        return false;
      }

      _user = await _userRepository.createUser(
        name: _nameController.value,
        password: _passwordController.value,
      );

      _appBloc.setUser(_user);
      _stateController.add(RegisterState.SUCCESS);
      return true;
    } catch (e) {
      print('register_bloc:register() $e');
      _stateController.add(RegisterState.FAIL);
      message = Strings.authRegisterMessageError;
      return false;
    }
  }
}
