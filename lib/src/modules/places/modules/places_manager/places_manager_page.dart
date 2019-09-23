import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/fonts/smart_home_places_icons.dart';
import '../../../../shared/icons_list/places_icons_list.dart';
import '../../../../shared/languages/en/strings.dart';
import '../../../../shared/models/place/place_model.dart';
import '../../../../shared/widgets/components/mqtt_status.dart';
import '../../../../shared/widgets/fields/icon_picker/icon_picker_field.dart';
import '../../../../shared/widgets/fields/stream_input/stream_input_textfield.dart';
import 'places_manager_bloc.dart';
import 'widgets/floating_buttons.dart';

class PlacesManagerPage extends StatefulWidget {
  final PlaceModel _place;

  PlacesManagerPage(this._place);

  @override
  _PlacesManagerPageState createState() => _PlacesManagerPageState();
}

class _PlacesManagerPageState extends State<PlacesManagerPage> {
  IconData _icon;
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _icon = SmartHomePlacesIcons.house;

    if (widget._place != null) {
      _nameController.text = widget._place.name;
      _icon = IconData(widget._place.icon);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    _bloc.setIcon = _icon.codePoint.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.placesManager),
        actions: <Widget>[
          MqttStatus(),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: StreamBuilder<PlacesManagerState>(
          stream: _bloc.streamState,
          builder: (context, snapshot) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                snapshot.data == PlacesManagerState.LOADING
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
                  fontFamily: 'SmartHomePlacesIcons',
                  icons: placesIconsList,
                  action: (newIcon) => setState(() {
                    _bloc.setIcon = newIcon.codePoint.toString();
                    _icon = newIcon;
                  }),
                ),
                //SaveButton(),
              ],
            );
          },
        ),
      ),
      floatingActionButton: PlacesFloatingButtons(),
    );
  }
}
