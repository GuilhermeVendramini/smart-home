import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/models/place/place_model.dart';
import '../../../../devices/devices_module.dart';
import '../../../places_module.dart';
import '../places_manager_bloc.dart';

class PlacesSaveButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    final PlaceModel _currentPlace = _bloc.getCurrentPlace;
    void _submit() async {
      PlaceModel _place = _currentPlace == null
          ? await _bloc.addPlace()
          : await _bloc.updatePlace();

      if (_place == null) {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_bloc.message),
            duration: Duration(seconds: 3),
          ),
        );
      }
      if (_place != null && _currentPlace == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DevicesModule(
              _place,
            ),
          ),
        );
      }
      if (_place != null && _currentPlace != null) {
        Navigator.of(context).pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => PlacesModule()),
        );
      }
    }

    return StreamBuilder<bool>(
      stream: _bloc.outSubmitValid,
      builder: (context, snapshot) {
        return FloatingActionButton(
          heroTag: 'save',
          child: Icon(Icons.check),
          backgroundColor: snapshot.hasData
              ? Theme.of(context).floatingActionButtonTheme.backgroundColor
              : Theme.of(context).disabledColor,
          onPressed: snapshot.hasData ? _submit : null,
        );
      },
    );
  }
}
