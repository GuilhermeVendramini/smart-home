import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../src/shared/languages/pt-br/strings.dart';
import '../../../../../src/shared/widgets/components/side_drawer.dart';
import '../../../../../src/shared/widgets/fields/stream_input/stream_input_checkbox.dart';
import '../../../../../src/shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'switch_plugin_bloc.dart';
import 'widgets/save_button.dart';

class SwitchPluginPage extends StatefulWidget {
  @override
  _SwitchPluginState createState() => _SwitchPluginState();
}

class _SwitchPluginState extends State<SwitchPluginPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<SwitchPluginProvider>(context);
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Strings.switchPluginTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: StreamBuilder<SavePluginState>(
        stream: _bloc.getState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == SavePluginState.SAVING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputTextField(
                hint: Strings.switchTopic,
                obscure: false,
                stream: _bloc.getTopic,
                onChanged: _bloc.changeTopic,
              ),
              StreamInputTextField(
                hint: Strings.switchMessageOn,
                stream: _bloc.getMessageOn,
                onChanged: _bloc.changeMessageOn,
              ),
              StreamInputTextField(
                hint: Strings.switchMessageOff,
                stream: _bloc.getMessageOff,
                onChanged: _bloc.changeMessageOff,
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(Strings.switchStatus),
              StreamInputCheckboxField(
                stream: _bloc.getStatus,
                onChanged: _bloc.changeStatus,
              ),
              SaveButton(),
            ],
          );
        },
      ),
    );
  }
}
