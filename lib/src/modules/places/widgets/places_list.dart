import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../places_bloc.dart';
import 'places_card.dart';
import 'places_card_add.dart';

class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesProvider>(context);
    final _places = _bloc.getPlaces;
    return GridView.builder(
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _places.length + 1,
        itemBuilder: (context, index) {
          if (index == _places.length) {
            return PlacesCardAdd();
          }
          return PlacesCard(_places[index]);
        });
  }
}
