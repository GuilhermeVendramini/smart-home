import 'package:flutter/foundation.dart';

import '../../app_bloc.dart';
import 'home_validators.dart';

class HomeBloc extends ChangeNotifier with HomeValidators {
  final AppProvider _appBloc;

  HomeBloc(this._appBloc);

  @override
  void dispose() async {
    super.dispose();
  }
}

class Home extends HomeBloc {
  Home(AppBloc appBloc) : super(appBloc);

/*
  * Getters here
  * */
}

class HomeProvider extends Home {
  HomeProvider(AppBloc appBloc) : super(appBloc);

/*
  * Functions here
  * */
}
