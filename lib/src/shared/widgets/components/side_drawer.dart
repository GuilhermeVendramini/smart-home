import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_bloc.dart';
import '../../../shared/languages/pt-br/strings.dart';

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<AppProvider>(context);
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: _bloc.getUser != null
                    ? Text(
                        _bloc.getUser.name,
                        style: TextStyle(fontSize: 18.0),
                      )
                    : Container(),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text(Strings.authLogout),
                onTap: () async {
                  Navigator.pop(context);
                  await _bloc.cleanUser();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
