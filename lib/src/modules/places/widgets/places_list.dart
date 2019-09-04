import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../places_bloc.dart';

/*class PlacesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesProvider>(context);
    _bloc.loadPlaces();
    return StreamBuilder<PlacesState>(
      stream: _bloc.getState,
      builder: (context, snapshot) {
        switch (snapshot.data) {
          case PlacesState.LOADING:
            {
              return CircularProgressIndicator();
            }
            break;
          case PlacesState.FAIL:
            {
              return Text('Error loading places');
            }
            break;
          case PlacesState.SUCCESS:
            {
              return Text('OK');
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
}*/

class PlacesList extends StatelessWidget {
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
              return Text('Error loading places');
            }
            break;
          case PlacesState.SUCCESS:
            {
              return Text('${_bloc.getPlaces[0].name}');
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
