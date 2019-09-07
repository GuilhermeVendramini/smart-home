import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_home/src/shared/languages/pt-br/strings.dart';

import 'mqtt_validators.dart';

enum MqttState { SAVING, SUCCESS, FAIL }

class MqttBloc extends ChangeNotifier with MqttValidators {
  final BehaviorSubject<String> _brokerController = BehaviorSubject<String>();
  final BehaviorSubject<String> _clientIdentifierController = BehaviorSubject<String>();
  final BehaviorSubject<String> _mqttUserController = BehaviorSubject<String>();
  final BehaviorSubject<String> _mqttPasswordController = BehaviorSubject<String>();
  final BehaviorSubject<MqttState> _stateController = BehaviorSubject<MqttState>();

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
  Stream<String> get getBroker => _brokerController.stream.transform(validateBroker);
  Stream<String> get getClientIdentifier => _clientIdentifierController.stream.transform(validateClientIdentifier);
  Stream<String> get getUser => _mqttUserController.stream.transform(validateMqttUser);
  Stream<String> get getPassword =>
      _mqttPasswordController.stream.transform(validateMqttPassword);
  Stream<MqttState> get getState => _stateController.stream;
  Function(String) get changeUser => _mqttUserController.sink.add;
  Function(String) get changePassword => _mqttPasswordController.sink.add;
  Function(String) get changeBroker => _brokerController.sink.add;
  Function(String) get changeClientIdentifier => _clientIdentifierController.sink.add;
  Stream<bool> get outSubmitValid =>
      Observable.combineLatest4(getBroker, getClientIdentifier, getUser, getPassword, (a, b, c, d) => true);
}

class MqttProvider extends Mqtt {
  Future<bool> save() async {
    try {
      _stateController.add(MqttState.SAVING);
      // DO SOMETHING

      _stateController.add(MqttState.SUCCESS);
      return true;
    } catch (e) {
      print('mqtt_bloc:save() $e');
      _stateController.add(MqttState.FAIL);
      message = Strings.mqttSaveMessageError;
      return false;
    }
  }
}
