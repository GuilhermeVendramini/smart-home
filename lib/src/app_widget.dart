import 'package:flutter/material.dart';

import 'app_theme.dart';
import 'modules/places/places_module.dart';
import 'shared/languages/en/strings.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppTheme.systemChrome;

    return MaterialApp(
      title: Strings.devicesTitle,
      theme: AppTheme.themeData,
      home: PlacesModule(),
    );
  }
}
