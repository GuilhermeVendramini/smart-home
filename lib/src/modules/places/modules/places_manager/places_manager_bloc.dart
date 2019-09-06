import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../repositories/hasura/places/hasura_places_repository.dart';
import '../../../../shared/languages/pt-br/strings.dart';
import '../../../../shared/models/place/place_model.dart';
import '../../places_bloc.dart';
import 'places_manager_validators.dart';

enum PlacesManagerState { LOADING, SUCCESS, FAIL }

class PlacesManagerBloc extends ChangeNotifier with PlacesManagerValidators {
  final PlacesProvider _placesProvider;
  final HasuraPlacesRepository _placesRepository;

  PlacesManagerBloc(this._placesProvider, this._placesRepository);

  final _nameController = BehaviorSubject<String>();
  final _iconController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<PlacesManagerState>();
  String message;

  @override
  void dispose() async {
    _nameController.close();
    _iconController.close();
    _stateController.close();
    super.dispose();
  }
}

class PlacesManager extends PlacesManagerBloc {
  PlacesManager(
      PlacesProvider placesProvider, HasuraPlacesRepository placesRepository)
      : super(placesProvider, placesRepository);

  Stream<String> get getName => _nameController.stream.transform(validateName);

  Stream<String> get getIcon => _iconController.stream.transform(validateIcon);

  Stream<PlacesManagerState> get streamState => _stateController.stream;

  Function(String) get changeName => _nameController.sink.add;

  set setIcon(String icon) {
    _iconController.sink.add(icon);
  }

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(getName, getIcon, (a, b) => true);
}

class PlacesManagerProvider extends PlacesManager {
  PlacesManagerProvider(
      PlacesProvider placesProvider, HasuraPlacesRepository placesRepository)
      : super(placesProvider, placesRepository);

  Future<PlaceModel> addPlace() async {
    try {
      _stateController.add(PlacesManagerState.LOADING);
      PlaceModel _place;

      _place = await _placesRepository.createPlace(
        name: _nameController.value,
        icon: _iconController.value,
      );

      message = Strings.placesSavedSuccessfully;
      _placesProvider.addPlace(_place);
      _stateController.add(PlacesManagerState.SUCCESS);
      return _place;
    } catch (e) {
      print('places_bloc:addUser() $e');
      _stateController.add(PlacesManagerState.FAIL);
      message = Strings.placesErrorSaving;
      return null;
    }
  }
}
