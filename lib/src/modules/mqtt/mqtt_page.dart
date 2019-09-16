import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/languages/pt-br/strings.dart';
import '../../shared/widgets/components/mqttStatus.dart';
import '../../shared/widgets/components/side_drawer.dart';
import '../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'mqtt_bloc.dart';
import 'widgets/save_button.dart';

class MqttPage extends StatefulWidget {
  @override
  _MqttPageState createState() => _MqttPageState();
}

class _MqttPageState extends State<MqttPage> {
  final _mqttBrokerController = TextEditingController();
  final _mqttClientIdentifierController = TextEditingController();
  final _mqttUserController = TextEditingController();
  final _mqttPasswordController = TextEditingController();
  final _mqttPortController = TextEditingController();

  @override
  void initState() {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((pref) {
      final String _mqttBroker = pref.getString('mqttBroker');
      final String _mqttClientIdentifier =
          pref.getString('mqttClientIdentifier');
      final String _mqttUser = pref.getString('mqttUser');
      final String _mqttPassword = pref.getString('mqttPassword');
      final String _mqttPort = pref.getString('mqttPort');

      _mqttBrokerController.text = _mqttBroker != null ? _mqttBroker : '';
      _mqttClientIdentifierController.text =
          _mqttClientIdentifier != null ? _mqttClientIdentifier : '';
      _mqttUserController.text = _mqttUser != null ? _mqttUser : '';
      _mqttPasswordController.text = _mqttPassword != null ? _mqttPassword : '';
      _mqttPortController.text = _mqttPort != null ? _mqttPort : '';
    });

    super.initState();
  }

  @override
  void dispose() {
    _mqttBrokerController.dispose();
    _mqttClientIdentifierController.dispose();
    _mqttUserController.dispose();
    _mqttPasswordController.dispose();
    _mqttPortController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<MqttProvider>(context);

    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text('MQTT'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        actions: <Widget>[
          MqttStatus(),
        ],
      ),
      body: StreamBuilder<MqttState>(
        stream: _bloc.getState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == MqttState.SAVING ||
                      snapshot.data == MqttState.CONNECTING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputTextField(
                controller: _mqttBrokerController,
                hint: Strings.mqttBroker,
                obscure: false,
                stream: _bloc.getBroker,
                onChanged: _bloc.changeBroker,
              ),
              StreamInputTextField(
                controller: _mqttClientIdentifierController,
                hint: Strings.mqttClientIdentifier,
                obscure: false,
                stream: _bloc.getClientIdentifier,
                onChanged: _bloc.changeClientIdentifier,
              ),
              StreamInputTextField(
                controller: _mqttUserController,
                hint: Strings.mqttUser,
                obscure: false,
                stream: _bloc.getUser,
                onChanged: _bloc.changeUser,
              ),
              StreamInputTextField(
                controller: _mqttPortController,
                hint: Strings.mqttPort,
                obscure: false,
                stream: _bloc.getPort,
                onChanged: _bloc.changePort,
              ),
              StreamInputTextField(
                controller: _mqttPasswordController,
                hint: Strings.mqttPassword,
                obscure: false,
                stream: _bloc.getPassword,
                onChanged: _bloc.changePassword,
              ),
              SaveButton(),
            ],
          );
        },
      ),
    );
  }
}
