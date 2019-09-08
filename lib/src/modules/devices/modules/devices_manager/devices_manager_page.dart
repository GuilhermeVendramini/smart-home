import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/register_button.dart';
import '../../../../shared/fonts/smart_home_devices_icons.dart';
import '../../../../shared/icons_list/devices_icons_list.dart';
import '../../../../shared/languages/pt-br/strings.dart';
import '../../../../shared/widgets/fields/icon_picker/icon_picker_field.dart';
import '../../../../shared/widgets/fields/stream_input/stream_input_field.dart';
import '../../../../shared/widgets/components/mqttStatus.dart';
import 'devices_manager_bloc.dart';

class DevicesManagerPage extends StatefulWidget {
  @override
  _DevicesManagerPageState createState() => _DevicesManagerPageState();
}

class _DevicesManagerPageState extends State<DevicesManagerPage> {
  IconData _icon;

  @override
  void initState() {
    super.initState();
    _icon = SmartHomeDevicesIcons.home;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesManagerProvider>(context);
    _bloc.setIcon = _icon.codePoint.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.devicesAdd),
        actions: <Widget>[
          MqttStatus(),
        ],
      ),
      body: StreamBuilder<DevicesManagerState>(
        stream: _bloc.streamState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == DevicesManagerState.LOADING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputField(
                hint: Strings.name,
                stream: _bloc.getName,
                onChanged: _bloc.changeName,
              ),
              SizedBox(
                height: 10.0,
              ),
              FieldIconPicker(
                iconData: _icon,
                fontFamily: 'SmartHomeDevicesIcons',
                icons: devicesIconsList,
                action: (newIcon) => setState(() {
                  _bloc.setIcon = newIcon.codePoint.toString();
                  _icon = newIcon;
                }),
              ),
              RegisterButton(),
            ],
          );
        },
      ),
    );
  }
}
