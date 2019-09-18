import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../modules/places_manager/places_manager_module.dart';
import '../places_bloc.dart';

class PlacesCardAdd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlacesManagerModule(_bloc, null),
          ),
        );
      },
      child: Card(
        child: Icon(
          Icons.add,
          size: 40.0,
        ),
      ),
    );
  }
}
