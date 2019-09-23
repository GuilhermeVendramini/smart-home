import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/fonts/smart_home_devices_icons.dart';
import '../../../../shared/icons_list/devices_icons_list.dart';
import '../../../../shared/languages/en/strings.dart';
import '../../../../shared/models/device/device_model.dart';
import '../../../../shared/widgets/components/mqtt_status.dart';
import '../../../../shared/widgets/fields/icon_picker/icon_picker_field.dart';
import '../../../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'devices_manager_bloc.dart';
import 'widgets/floating_buttons.dart';

class DevicesManagerPage extends StatefulWidget {
  final DeviceModel _device;

  DevicesManagerPage(this._device);

  @override
  _DevicesManagerPageState createState() => _DevicesManagerPageState();
}

class _DevicesManagerPageState extends State<DevicesManagerPage> {
  IconData _icon;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _icon = SmartHomeDevicesIcons.home;

    if (widget._device != null) {
      _nameController.text = widget._device.name;
      _icon = IconData(widget._device.icon);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesManagerProvider>(context);
    _bloc.setIcon = _icon.codePoint.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.devicesManager),
        actions: <Widget>[
          MqttStatus(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<DevicesManagerState>(
          stream: _bloc.streamState,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                snapshot.data == DevicesManagerState.LOADING
                    ? CircularProgressIndicator()
                    : SizedBox(height: 35.0),
                StreamInputTextField(
                  helperText: Strings.name,
                  controller: _nameController,
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
              ],
            );
          },
        ),
      ),
      floatingActionButton: DevicesFloatingButtons(),
    );
  }
}
