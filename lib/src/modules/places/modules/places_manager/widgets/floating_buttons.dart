import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/models/place/place_model.dart';
import '../places_manager_bloc.dart';
import 'delete_button.dart';
import 'save_button.dart';

class PlacesFloatingButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    final PlaceModel _currentPlace = _bloc.getCurrentPlace;

    if (_currentPlace != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          PlacesDeleteButton(),
          PlacesSaveButton(),
        ],
      );
    }

    return PlacesSaveButton();
  }
}
