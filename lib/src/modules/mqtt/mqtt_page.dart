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
      body: StreamBuilder<MqttState>(
        stream: _bloc.getState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == MqttState.SAVING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputField(
                hint: Strings.mqttBroker,
                obscure: false,
                stream: _bloc.getBroker,
                onChanged: _bloc.changeBroker,
              ),
              StreamInputField(
                hint: Strings.mqttClientIdentifier,
                obscure: false,
                stream: _bloc.getClientIdentifier,
                onChanged: _bloc.changeClientIdentifier,
              ),
              StreamInputField(
                hint: Strings.mqttUser,
                obscure: false,
                stream: _bloc.getUser,
                onChanged: _bloc.changeUser,
              ),
              StreamInputField(
                hint: Strings.mqttPassword,
                obscure: true,
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
