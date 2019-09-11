import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/register_button.dart';
import '../../../../shared/fonts/smart_home_places_icons.dart';
import '../../../../shared/icons_list/places_icons_list.dart';
import '../../../../shared/languages/pt-br/strings.dart';
import '../../../../shared/widgets/components/mqttStatus.dart';
import '../../../../shared/widgets/fields/icon_picker/icon_picker_field.dart';
import '../../../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'places_manager_bloc.dart';

class PlacesManagerPage extends StatefulWidget {
  @override
  _PlacesManagerPageState createState() => _PlacesManagerPageState();
}

class _PlacesManagerPageState extends State<PlacesManagerPage> {
  IconData _icon;

  @override
  void initState() {
    super.initState();
    _icon = SmartHomePlacesIcons.house;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    _bloc.setIcon = _icon.codePoint.toString();
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.placesAdd),
        actions: <Widget>[
          MqttStatus(),
        ],
      ),
      body: StreamBuilder<PlacesManagerState>(
        stream: _bloc.streamState,
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              snapshot.data == PlacesManagerState.LOADING
                  ? CircularProgressIndicator()
                  : SizedBox(height: 35.0),
              StreamInputTextField(
                hint: Strings.name,
                stream: _bloc.getName,
                onChanged: _bloc.changeName,
              ),
              SizedBox(
                height: 10.0,
              ),
              FieldIconPicker(
                iconData: _icon,
                fontFamily: 'SmartHomePlacesIcons',
                icons: placesIconsList,
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
