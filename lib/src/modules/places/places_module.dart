import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../repositories/sqflite/places/sqflite_places_repository.dart';
import 'places_bloc.dart';
import 'places_page.dart';

class PlacesModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlacesProvider>(
            builder: (_) => PlacesProvider(
                  SQFLitePlacesRepository(),
                )),
      ],
      child: PlacesPage(),
    );
  }
}
