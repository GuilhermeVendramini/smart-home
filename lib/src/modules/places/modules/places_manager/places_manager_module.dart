import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../repositories/hasura/places/hasura_places_repository.dart';
import '../../places_bloc.dart';
import 'places_manager_bloc.dart';
import 'places_manager_page.dart';

class PlacesManagerModule extends StatelessWidget {
  final PlacesProvider _placesProvider;

  PlacesManagerModule(this._placesProvider);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlacesManagerProvider>(
            builder: (_) => PlacesManagerProvider(
                  _placesProvider,
                  HasuraPlacesRepository(),
                )),
      ],
      child: PlacesManagerPage(),
    );
  }
}
