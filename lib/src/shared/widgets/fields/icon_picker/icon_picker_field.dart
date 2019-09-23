import 'package:flutter/material.dart';

import '../../../languages/en/strings.dart';
import 'icon_display.dart';
import 'icon_picker.dart';

class FieldIconPicker extends StatelessWidget {
  final IconData iconData;
  final ValueChanged<IconData> action;
  final String fontFamily;
  final List<IconData> icons;

  FieldIconPicker({
    @required this.iconData,
    @required this.fontFamily,
    @required this.icons,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(top: 40.0),
              title: Text(
                Strings.iconPickerTitleBox,
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: IconPicker(
                  highlightColor: Theme.of(context).accentColor,
                  currentIconData: iconData,
                  fontFamily: fontFamily,
                  icons: icons,
                  onIconChanged: action,
                  outlineColor: Theme.of(context).disabledColor,
                ),
              ),
            );
          },
        );
      },
      child: IconDisplay(
        codePoint: iconData.codePoint,
        fontFamily: fontFamily,
        outlineColor: Theme.of(context).accentColor,
      ),
    );
  }
}
