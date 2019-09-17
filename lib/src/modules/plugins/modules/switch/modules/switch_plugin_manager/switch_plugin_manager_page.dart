import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../shared/languages/pt-br/strings.dart';
import '../../../../../../shared/models/plugin/plugin_model.dart';
import '../../../../../../shared/widgets/components/side_drawer.dart';
import '../../../../../../shared/widgets/fields/stream_input/stream_input_checkbox.dart';
import '../../../../../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'switch_plugin_manager_bloc.dart';
import 'widgets/save_button.dart';

class SwitchPluginManagerPage extends StatefulWidget {
  final PluginModel _plugin;

  SwitchPluginManagerPage(this._plugin);

  @override
  _SwitchPluginManagerState createState() => _SwitchPluginManagerState();
}

class _SwitchPluginManagerState extends State<SwitchPluginManagerPage> {
  final _topicController = TextEditingController();
  final _messageOnController = TextEditingController();
  final _messageOffController = TextEditingController();
  final _topicResultController = TextEditingController();
  final _resultOnController = TextEditingController();
  final _resultOffController = TextEditingController();
  bool _statusValue = false;

  @override
  void initState() {
    super.initState();

    if (widget._plugin != null) {
      _topicController.text = widget._plugin.config["topic"];
      _messageOnController.text = widget._plugin.config["messageOn"];
      _messageOffController.text = widget._plugin.config["messageOff"];
      _topicResultController.text = widget._plugin.config["topicResult"];
      _resultOnController.text = widget._plugin.config["resultOn"];
      _resultOffController.text = widget._plugin.config["resultOff"];
      _statusValue = widget._plugin.status;
    }
  }

  @override
  void dispose() {
    _topicController.dispose();
    super.dispose();
  }

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
                  controller: _topicController,
                  hint: Strings.switchTopic,
                  obscure: false,
                  stream: _bloc.getTopic,
                  onChanged: _bloc.changeTopic,
                ),
                StreamInputTextField(
                  controller: _messageOnController,
                  hint: Strings.switchMessageOn,
                  stream: _bloc.getMessageOn,
                  onChanged: _bloc.changeMessageOn,
                ),
                StreamInputTextField(
                  controller: _messageOffController,
                  hint: Strings.switchMessageOff,
                  stream: _bloc.getMessageOff,
                  onChanged: _bloc.changeMessageOff,
                ),
                SizedBox(
                  height: 10.0,
                ),
                StreamInputTextField(
                  controller: _topicResultController,
                  hint: Strings.switchTopicResult,
                  obscure: false,
                  stream: _bloc.getTopicResult,
                  onChanged: _bloc.changeTopicResult,
                ),
                StreamInputTextField(
                  controller: _resultOnController,
                  hint: Strings.switchResultOn,
                  stream: _bloc.getResultOn,
                  onChanged: _bloc.changeResultOn,
                ),
                StreamInputTextField(
                  controller: _resultOffController,
                  hint: Strings.switchResultOff,
                  stream: _bloc.getResultOff,
                  onChanged: _bloc.changeResultOff,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(Strings.switchStatus),
                StreamInputCheckboxField(
                  defaultValue: _statusValue,
                  stream: _bloc.getStatus,
                  onChanged: _bloc.changeStatus,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: SaveButton(),
    );
  }
}
