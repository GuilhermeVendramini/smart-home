import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../shared/colors/default_colors.dart';
import '../../../../../shared/languages/en/strings.dart';
import '../../../devices_module.dart';
import '../devices_manager_bloc.dart';

class DevicesDeleteButton extends StatelessWidget {
  Future<void> _confirmDelete(
      BuildContext context, DevicesManagerProvider _bloc) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.devicesConfirmDelete),
          content: const Text(Strings.devicesConfirmDeleteMessage),
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
                bool _result = await _bloc.deleteDevice();
                if (_result) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DevicesModule(
                        _bloc.getCurrentPlace,
                      ),
                    ),
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
    final _bloc = Provider.of<DevicesManagerProvider>(context);
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
