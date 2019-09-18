import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../modules/devices/devices_module.dart';
import '../../../modules/places/modules/places_manager/places_manager_module.dart';
import '../../../shared/models/place/place_model.dart';
import '../places_bloc.dart';

class PlacesCard extends StatelessWidget {
  final PlaceModel _place;

  PlacesCard(this._place);

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesProvider>(context);
    return InkWell(
      onLongPress: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacesManagerModule(
              _bloc,
              _place,
            ),
          ),
        );
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DevicesModule(
              _place,
            ),
          ),
        );
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              IconData(_place.icon, fontFamily: 'SmartHomePlacesIcons'),
              size: 40.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              _place.name,
              style: Theme.of(context).textTheme.subtitle,
            ),
          ],
        ),
      ),
    );
  }
}
