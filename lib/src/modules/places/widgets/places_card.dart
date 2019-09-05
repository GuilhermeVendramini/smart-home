import 'package:flutter/material.dart';

import '../../../shared/models/place/place_model.dart';

class PlacesCard extends StatelessWidget {
  final PlaceModel _place;

  PlacesCard(this._place);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconData(int.tryParse(_place.icon), fontFamily: 'SmartHomeIcons'),
            ),
            Text(_place.name),
          ],
        ),
      ),
    );
  }
}
