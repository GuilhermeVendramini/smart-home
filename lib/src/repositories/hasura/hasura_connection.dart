import 'package:hasura_connect/hasura_connect.dart';

abstract class HasuraConnection {
  HasuraConnect hasuraConnect =
      HasuraConnect("https://flutter-smart-home.herokuapp.com/v1/graphql");

  dispose();
}
