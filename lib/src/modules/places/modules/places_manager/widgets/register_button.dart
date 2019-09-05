import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/languages/pt-br/strings.dart';
import '../../../../../shared/models/place/place_model.dart';
import '../places_manager_bloc.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    void _submit() async {
      PlaceModel _place = await _bloc.addPlace();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(_bloc.message),
          duration: Duration(seconds: 3),
        ),
      );
      if (_place != null) {
        Navigator.pop(context);
      }
    }

    return StreamBuilder<bool>(
      stream: _bloc.outSubmitValid,
      builder: (context, snapshot) {
        return RaisedButton(
          child: Text(Strings.save),
          onPressed: snapshot.hasData ? _submit : null,
        );
      },
    );
  }
}
