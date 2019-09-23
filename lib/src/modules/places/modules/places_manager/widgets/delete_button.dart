import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/colors/default_colors.dart';
import '../../../../../shared/languages/en/strings.dart';
import '../../../places_module.dart';
import '../places_manager_bloc.dart';

class PlacesDeleteButton extends StatelessWidget {
  Future<void> _confirmDelete(
      BuildContext context, PlacesManagerProvider _bloc) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.placesConfirmDelete),
          content: const Text(Strings.placesConfirmDeleteMessage),
          actions: <Widget>[
            FlatButton(
              child: const Text(Strings.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: const Text(Strings.confirm),
              onPressed: () async {
                bool _result = await _bloc.deletePlace();
                if (_result) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => PlacesModule()),
                  );
                }
              },
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<PlacesManagerProvider>(context);
    return FloatingActionButton(
      heroTag: "delete",
      child: Icon(Icons.delete),
      backgroundColor: DefaultColors.red,
      onPressed: () async {
        await _confirmDelete(context, _bloc);
      },
    );
  }
}
