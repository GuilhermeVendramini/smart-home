import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: FutureBuilder<Map<String, dynamic>>(
        future: _bloc.getMqttValues(),
        initialData: {},
        builder: (context, snapshot) {
          Map<String, dynamic> _data = snapshot.data;
          _mqttBrokerController.text =
              _data['mqttBroker'] != null ? _data['mqttBroker'] : '';
          _mqttClientIdentifierController.text =
              _data['mqttClientIdentifier'] != null
                  ? _data['mqttClientIdentifier']
                  : '';
          _mqttUserController.text =
              _data['mqttUser'] != null ? _data['mqttUser'] : '';
          _mqttPasswordController.text =
              _data['mqttPassword'] != null ? _data['mqttPassword'] : '';
          _mqttPortController.text =
              _data['mqttPort'] != null ? _data['mqttPort'] : '';

          return StreamBuilder<MqttState>(
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
          );
        },
      ),
    );
  }
}
