import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../shared/widgets/fields/stream_input_field.dart';

import './widgets/register_button.dart';
import 'places_manager_bloc.dart';

class PlacesManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Item"),
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
              StreamInputField(
                hint: "Name",
                stream: _bloc.getName,
                onChanged: _bloc.changeName,
              ),
              StreamInputField(
                hint: "Icon",
                stream: _bloc.getIcon,
                onChanged: _bloc.changePassword,
              ),
              RegisterButton(),
            ],
          );
        },
      ),
    );
  }
}
