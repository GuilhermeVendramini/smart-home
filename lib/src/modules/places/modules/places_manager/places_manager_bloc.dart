import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../repositories/sqflite/places/sqflite_places_repository.dart';
import '../../../../shared/languages/en/strings.dart';
import '../../../../shared/models/place/place_model.dart';
import '../../places_bloc.dart';
import 'places_manager_validators.dart';

enum PlacesManagerState { LOADING, SUCCESS, FAIL }

class PlacesManagerBloc extends ChangeNotifier with PlacesManagerValidators {
  final PlacesProvider _placesProvider;
  final SQFLitePlacesRepository _placesRepository;
  final PlaceModel _currentPlace;

  PlacesManagerBloc(
      this._placesProvider, this._currentPlace, this._placesRepository);

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
  PlacesManager(PlacesProvider placesProvider, PlaceModel currentPlace,
      SQFLitePlacesRepository placesRepository)
      : super(placesProvider, currentPlace, placesRepository);

  Stream<String> get getName => _nameController.stream.transform(validateName);

  Stream<String> get getIcon => _iconController.stream.transform(validateIcon);

  Stream<PlacesManagerState> get streamState => _stateController.stream;

  Function(String) get changeName => _nameController.sink.add;

  PlaceModel get getCurrentPlace => _currentPlace;

  set setIcon(String icon) {
    _iconController.sink.add(icon);
  }

  Stream<bool> get outSubmitValid =>
      Observable.combineLatest2(getName, getIcon, (a, b) => true);
}

class PlacesManagerProvider extends PlacesManager {
  PlacesManagerProvider(PlacesProvider placesProvider, PlaceModel currentPlace,
      SQFLitePlacesRepository placesRepository)
      : super(placesProvider, currentPlace, placesRepository) {
    if (currentPlace != null) {
      _nameController.add(_currentPlace.name);
    }
  }

  Future<PlaceModel> addPlace() async {
    try {
      _stateController.add(PlacesManagerState.LOADING);
      PlaceModel _place;

      _place = await _placesRepository.createPlace(
        name: _nameController.value,
        icon: int.tryParse(_iconController.value),
      );

      _placesProvider.addPlace(_place);
      _stateController.add(PlacesManagerState.SUCCESS);
      return _place;
    } catch (e) {
      print('places_manager_bloc:addUser() $e');
      _stateController.add(PlacesManagerState.FAIL);
      message = Strings.placesErrorSaving;
      return null;
    }
  }

  Future<PlaceModel> updatePlace() async {
    try {
      _stateController.add(PlacesManagerState.LOADING);
      PlaceModel _place;

      _place = await _placesRepository.updatePlace(PlaceModel(
        id: _currentPlace.id,
        name: _nameController.value,
        icon: int.tryParse(_iconController.value),
      ));

      _stateController.add(PlacesManagerState.SUCCESS);
      return _place;
    } catch (e) {
      print('places_manager_bloc:updatePlace() $e');
      _stateController.add(PlacesManagerState.FAIL);
      message = Strings.placesErrorUpdating;
      return null;
    }
  }

  Future<bool> deletePlace() async {
    try {
      _stateController.add(PlacesManagerState.LOADING);
      bool _result;

      _result = await _placesRepository.deletePlace(_currentPlace.id);

      _stateController.add(PlacesManagerState.SUCCESS);
      return _result;
    } catch (e) {
      print('places_manager_bloc:deletePlace() $e');
      _stateController.add(PlacesManagerState.FAIL);
      message = Strings.placesErrorDeleting;
      return false;
    }
  }
}
