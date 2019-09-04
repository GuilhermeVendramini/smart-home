import 'package:flutter/foundation.dart';
import '../../repositories/hasura/places/hasura_places_repository.dart';
import '../../shared/models/place/place_model.dart';
import 'places_validators.dart';

enum PlacesState { LOADING, SUCCESS, FAIL }

class PlacesBloc extends ChangeNotifier with PlacesValidators {
  final HasuraPlacesRepository _placesRepository;

  PlacesBloc(this._placesRepository);

  List<PlaceModel> _places;

  @override
  void dispose() async {
    super.dispose();
  }
}

class Places extends PlacesBloc {
  Places(HasuraPlacesRepository placesRepository) : super(placesRepository);

  List<PlaceModel> get getPlaces => _places;
}

class PlacesProvider extends Places {
  PlacesProvider(HasuraPlacesRepository placesRepository) : super(placesRepository);

  Future<PlacesState> loadPlaces() async {
    try {
      List<PlaceModel> _placesResult = List<PlaceModel>();
      _placesResult = await _placesRepository.getPlaces();
      if (_placesResult.isEmpty) {
        return PlacesState.SUCCESS;
      }

      _places = _placesResult;
      return PlacesState.SUCCESS;
    } catch (e) {
      print('places_bloc:loadPlaces() $e');
      return PlacesState.FAIL;
    }
  }
}
