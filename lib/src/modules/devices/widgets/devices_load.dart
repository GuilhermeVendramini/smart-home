import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/languages/en/strings.dart';
import '../devices_bloc.dart';
import 'devices_list.dart';

class DevicesLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bloc = Provider.of<DevicesProvider>(context);
    return FutureBuilder<DevicesState>(
      future: _bloc.loadDevices(),
      initialData: DevicesState.LOADING,
      builder: (BuildContext context, AsyncSnapshot<DevicesState> snapshot) {
        switch (snapshot.data) {
          case DevicesState.LOADING:
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            break;
          case DevicesState.FAIL:
            {
              return Center(
                child: Text(Strings.devicesLoadingMessageError),
              );
            }
            break;
          case DevicesState.SUCCESS:
            {
              return DevicesList();
            }
            break;
          default:
            {
              return Container();
            }
        }
      },
    );
  }
}
