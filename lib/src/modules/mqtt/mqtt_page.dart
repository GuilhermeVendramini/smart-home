import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/languages/pt-br/strings.dart';
import '../../shared/widgets/components/side_drawer.dart';
import '../../shared/widgets/fields/stream_input/stream_input_field.dart';
import 'mqtt_bloc.dart';
import 'widgets/save_button.dart';

class MqttPage extends StatefulWidget {
  @override
  _MqttPageState createState() => _MqttPageState();
}

class _MqttPageState extends State<MqttPage> {
  final _mqttBrokerController = TextEditingController();
  final _mqttClientIdentifier = TextEditingController();
  final _mqttUser = TextEditingController();
  final _mqttPassword = TextEditingController();

  @override
  void dispose() {
    _mqttBrokerController.dispose();
    _mqttClientIdentifier.dispose();
    _mqttUser.dispose();
    _mqttPassword.dispose();
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
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _bloc.getMqttValues(),
        initialData: {},
        builder: (context, snapshot) {
          Map<String, dynamic> _data = snapshot.data;
          _mqttBrokerController.text =  _data['mqttBroker'] != null ? _data['mqttBroker'] : '';
          _mqttClientIdentifier.text =  _data['mqttClientIdentifier'] != null ? _data['mqttClientIdentifier'] : '';
          _mqttUser.text =  _data['mqttUser'] != null ? _data['mqttUser'] : '';
          _mqttPassword.text =  _data['mqttPassword'] != null ? _data['mqttPassword'] : '';

          return StreamBuilder<MqttState>(
            stream: _bloc.getState,
            builder: (context, snapshot) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  snapshot.data == MqttState.SAVING
                      ? CircularProgressIndicator()
                      : SizedBox(height: 35.0),
                  StreamInputField(
                    controller: _mqttBrokerController,
                    hint: Strings.mqttBroker,
                    obscure: false,
                    stream: _bloc.getBroker,
                    onChanged: _bloc.changeBroker,
                  ),
                  StreamInputField(
                    controller: _mqttClientIdentifier,
                    hint: Strings.mqttClientIdentifier,
                    obscure: false,
                    stream: _bloc.getClientIdentifier,
                    onChanged: _bloc.changeClientIdentifier,
                  ),
                  StreamInputField(
                    controller: _mqttUser,
                    hint: Strings.mqttUser,
                    obscure: false,
                    stream: _bloc.getUser,
                    onChanged: _bloc.changeUser,
                  ),
                  StreamInputField(
                    controller: _mqttPassword,
                    hint: Strings.mqttPassword,
                    obscure: false,
                    stream: _bloc.getPassword,
                    onChanged: _bloc.changePassword,
                  ),
                  SaveButton(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
