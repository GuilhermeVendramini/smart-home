import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_home/src/shared/languages/pt-br/strings.dart';

import 'mqtt_validators.dart';

enum MqttState { SAVING, SUCCESS, FAIL }

class MqttBloc extends ChangeNotifier with MqttValidators {
  final BehaviorSubject<String> _brokerController = BehaviorSubject<String>();
  final BehaviorSubject<String> _clientIdentifierController =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _mqttUserController = BehaviorSubject<String>();
  final BehaviorSubject<String> _mqttPasswordController =
      BehaviorSubject<String>();
  final BehaviorSubject<MqttState> _stateController =
      BehaviorSubject<MqttState>();

  String message;

  @override
  void dispose() async {
    _brokerController.close();
    _clientIdentifierController.close();
    _mqttUserController.close();
    _mqttPasswordController.close();
    _stateController.close();
    super.dispose();
  }
}

class Mqtt extends MqttBloc {
  Stream<String> get getBroker =>
      _brokerController.stream.transform(validateBroker);

  Stream<String> get getClientIdentifier =>
      _clientIdentifierController.stream.transform(validateClientIdentifier);

  Stream<String> get getUser =>
      _mqttUserController.stream.transform(validateMqttUser);

  Stream<String> get getPassword =>
      _mqttPasswordController.stream.transform(validateMqttPassword);

  Stream<MqttState> get getState => _stateController.stream;

  Function(String) get changeUser => _mqttUserController.sink.add;

  Function(String) get changePassword => _mqttPasswordController.sink.add;

  Function(String) get changeBroker => _brokerController.sink.add;

  Function(String) get changeClientIdentifier =>
      _clientIdentifierController.sink.add;

  Stream<bool> get outSubmitValid => Observable.combineLatest4(getBroker,
      getClientIdentifier, getUser, getPassword, (a, b, c, d) => true);
}

class MqttProvider extends Mqtt {
  Future<bool> save() async {
    try {
      _stateController.add(MqttState.SAVING);

      final SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('mqttBroker', _brokerController.value);
      _prefs.setString(
          'mqttClientIdentifier', _clientIdentifierController.value);
      _prefs.setString('mqttUser', _mqttUserController.value);
      _prefs.setString('mqttPassword', _mqttPasswordController.value);

      _stateController.add(MqttState.SUCCESS);
      return true;
    } catch (e) {
      print('mqtt_bloc:save() $e');
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

      final Map<String, dynamic> _mqttConfig = {
        "mqttBroker": _mqttBroker != null ? _mqttBroker : '',
        "mqttClientIdentifier":
        _mqttClientIdentifier != null ? _mqttClientIdentifier : '',
        "mqttUser": _mqttUser != null ? _mqttUser : '',
        "mqttPassword": _mqttPassword != null ? _mqttPassword : '',
      };

      _brokerController.sink.add(_mqttConfig['mqttBroker']);
      _clientIdentifierController.sink.add(_mqttConfig['mqttClientIdentifier']);
      _mqttUserController.sink.add(_mqttConfig['mqttUser']);
      _mqttPasswordController.sink.add(_mqttConfig['mqttPassword']);

      return _mqttConfig;
    } catch (e) {
      print('mqtt_bloc:getMqttValues() $e');
      return {};
    }
  }
}
