import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/languages/pt-br/strings.dart';
import '../places_bloc.dart';
import 'places_list.dart';

class PlacesLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesProvider>(context);
    return FutureBuilder<PlacesState>(
      future: _bloc.loadPlaces(),
      initialData: PlacesState.LOADING,
      builder: (BuildContext context, AsyncSnapshot<PlacesState> snapshot) {
        switch (snapshot.data) {
          case PlacesState.LOADING:
            {
              return CircularProgressIndicator();
            }
            break;
          case PlacesState.FAIL:
            {
              return Text(Strings.placesLoadingMessageError);
            }
            break;
          case PlacesState.SUCCESS:
            {
              return PlacesList();
            }
            break;
          default:
            {
              return Container();
            }
        }
      },
    );
  }
}
