import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/sqflite/places/sqflite_places_repository.dart';
import '../../../../shared/models/place/place_model.dart';
import '../../places_bloc.dart';
import 'places_manager_bloc.dart';
import 'places_manager_page.dart';

class PlacesManagerModule extends StatelessWidget {
  final PlacesProvider _placesProvider;
  final PlaceModel _place;

  PlacesManagerModule(this._placesProvider, this._place);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlacesManagerProvider>(
            builder: (_) => PlacesManagerProvider(
                  _placesProvider,
                  _place,
                  SQFLitePlacesRepository(),
                )),
      ],
      child: PlacesManagerPage(_place),
    );
  }
}
