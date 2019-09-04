import 'package:flutter/foundation.dart';

import '../../app_bloc.dart';
import 'devices_validators.dart';

class DevicesBloc extends ChangeNotifier with DevicesValidators {
  final AppProvider _appBloc;

  DevicesBloc(this._appBloc);

  @override
  void dispose() async {
    super.dispose();
  }
}

class Devices extends DevicesBloc {
  Devices(AppBloc appBloc) : super(appBloc);

/*
  * Getters here
  * */
}

class DevicesProvider extends Devices {
  DevicesProvider(AppBloc appBloc) : super(appBloc);

/*
  * Functions here
  * */
}
