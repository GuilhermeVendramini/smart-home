import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/languages/pt-br/strings.dart';
import '../../../../../shared/models/place/place_model.dart';
import '../../../../devices/devices_module.dart';
import '../../../places_module.dart';
import '../places_manager_bloc.dart';

class SaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    final PlaceModel _currentPlace = _bloc.getCurrentPlace;
    void _submit() async {
      PlaceModel _place = _currentPlace == null
          ? await _bloc.addPlace()
          : await _bloc.updatePlace();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text(_bloc.message),
          duration: Duration(seconds: 3),
        ),
      );
      if (_place != null && _currentPlace == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DevicesModule(
                    _place,
                  )),
        );
      }
      if (_place != null && _currentPlace != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PlacesModule()),
        );
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
