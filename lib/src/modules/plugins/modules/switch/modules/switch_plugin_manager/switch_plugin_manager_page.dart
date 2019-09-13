import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/languages/pt-br/strings.dart';
import '../../../../../../shared/widgets/components/side_drawer.dart';
import '../../../../../../shared/widgets/fields/stream_input/stream_input_checkbox.dart';
import '../../../../../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'switch_plugin_manager_bloc.dart';
import 'widgets/save_button.dart';

class SwitchPluginManagerPage extends StatefulWidget {
  @override
  _SwitchPluginManagerState createState() => _SwitchPluginManagerState();
}

class _SwitchPluginManagerState extends State<SwitchPluginManagerPage> {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<SwitchPluginManagerProvider>(context);
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        title: Text(Strings.switchPluginTitle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<SavePluginState>(
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
                StreamInputTextField(
                  hint: Strings.switchTopicResult,
                  obscure: false,
                  stream: _bloc.getTopicResult,
                  onChanged: _bloc.changeTopicResult,
                ),
                StreamInputTextField(
                  hint: Strings.switchResultOn,
                  stream: _bloc.getResultOn,
                  onChanged: _bloc.changeResultOn,
                ),
                StreamInputTextField(
                  hint: Strings.switchResultOff,
                  stream: _bloc.getResultOff,
                  onChanged: _bloc.changeResultOff,
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
      ),
    );
  }
}
