import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app_bloc.dart';
import '../../shared/languages/pt-br/strings.dart';
import 'mqtt_validators.dart';

enum MqttState { SAVING, CONNECTING, SUCCESS, FAIL }

class MqttBloc extends ChangeNotifier with MqttValidators {
  final AppProvider _appBloc;

  MqttBloc(this._appBloc);

  final BehaviorSubject<String> _brokerController = BehaviorSubject<String>();
  final BehaviorSubject<String> _clientIdentifierController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _mqttUserController = BehaviorSubject<String>();
  final BehaviorSubject<String> _mqttPasswordController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _portController = BehaviorSubject<String>();
  final BehaviorSubject<MqttState> _stateController =
      BehaviorSubject<MqttState>();

  String message;

  @override
  void dispose() async {
    _brokerController.close();
    _clientIdentifierController.close();
    _mqttUserController.close();
    _mqttPasswordController.close();
    _portController.close();
    _stateController.close();
    super.dispose();
  }
}

class Mqtt extends MqttBloc {
  Mqtt(AppProvider appBloc) : super(appBloc);

  Stream<String> get getBroker =>
      _brokerController.stream.transform(validateBroker);

  Stream<String> get getClientIdentifier =>
      _clientIdentifierController.stream.transform(validateClientIdentifier);

  Stream<String> get getUser =>
      _mqttUserController.stream.transform(validateMqttUser);

  Stream<String> get getPassword =>
      _mqttPasswordController.stream.transform(validateMqttPassword);

  Stream<String> get getPort => _portController.stream.transform(validatePort);

  Stream<MqttState> get getState => _stateController.stream;

  Function(String) get changeUser => _mqttUserController.sink.add;

  Function(String) get changePassword => _mqttPasswordController.sink.add;

  Function(String) get changeBroker => _brokerController.sink.add;

  Function(String) get changeClientIdentifier =>
      _clientIdentifierController.sink.add;

  Function(String) get changePort => _portController.sink.add;

  Stream<bool> get outSubmitValid => Observable.combineLatest5(
      getBroker,
      getClientIdentifier,
      getUser,
      getPassword,
      getPort,
      (a, b, c, d, e) => true);
}

class MqttProvider extends Mqtt {
  MqttProvider(AppProvider appBloc) : super(appBloc);

  Future<bool> save() async {
    try {
      _stateController.add(MqttState.SAVING);

      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('mqttBroker', _brokerController.value);
      _prefs.setString(
          'mqttClientIdentifier', _clientIdentifierController.value);
      _prefs.setString('mqttUser', _mqttUserController.value);
      _prefs.setString('mqttPassword', _mqttPasswordController.value);
      _prefs.setString('mqttPort', _portController.value);
      _stateController.add(MqttState.CONNECTING);
      final bool connectResult = await _appBloc.mqttConnect();

      if (!connectResult) {
        _appBloc.mqttDisconnect();
        _stateController.add(MqttState.FAIL);
        message = Strings.mqttConnectMessageError;
        return false;
      }

      _stateController.add(MqttState.SUCCESS);
      return true;
    } catch (e) {
      print('mqtt_bloc:save() $e');
      _appBloc.mqttDisconnect();
      _stateController.add(MqttState.FAIL);
      message = Strings.mqttSaveMessageError;
      return false;
    }
  }

  Future<Map<String, dynamic>> getMqttValues() async {
    try {
      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      final String _mqttBroker = _prefs.getString('mqttBroker');
      final String _mqttClientIdentifier =
          _prefs.getString('mqttClientIdentifier');
      final String _mqttUser = _prefs.getString('mqttUser');
      final String _mqttPassword = _prefs.getString('mqttPassword');
      final String _mqttPort = _prefs.getString('mqttPort');

      final Map<String, dynamic> _mqttConfig = {
        "mqttBroker": _mqttBroker != null ? _mqttBroker : '',
        "mqttClientIdentifier":
            _mqttClientIdentifier != null ? _mqttClientIdentifier : '',
        "mqttUser": _mqttUser != null ? _mqttUser : '',
        "mqttPassword": _mqttPassword != null ? _mqttPassword : '',
        "mqttPort": _mqttPort != null ? _mqttPort : '',
      };

      _brokerController.sink.add(_mqttConfig['mqttBroker']);
      _clientIdentifierController.sink.add(_mqttConfig['mqttClientIdentifier']);
      _mqttUserController.sink.add(_mqttConfig['mqttUser']);
      _mqttPasswordController.sink.add(_mqttConfig['mqttPassword']);
      _portController.sink.add(_mqttConfig['mqttPort']);
      return _mqttConfig;
    } catch (e) {
      print('mqtt_bloc:getMqttValues() $e');
      return {};
    }
  }
}
