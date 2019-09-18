import 'package:flutter/material.dart';

import 'icon_display.dart';

class IconPicker extends StatefulWidget {
  final ValueChanged<IconData> onIconChanged;
  final IconData currentIconData;
  final Color highlightColor;
  final Color outlineColor;
  final String fontFamily;
  final List<IconData> icons;

  IconPicker({
    @required this.currentIconData,
    @required this.onIconChanged,
    @required this.fontFamily,
    @required this.icons,
    Color highlightColor,
    this.outlineColor,
  }) : this.highlightColor = highlightColor ?? Colors.blue;

  @override
  State<StatefulWidget> createState() {
    return _IconPickerState();
  }
}

class _IconPickerState extends State<IconPicker> {
  int selectedIconData;

  @override
  void initState() {
    selectedIconData = widget.currentIconData.codePoint;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      width: orientation == Orientation.portrait ? 300.0 : 300.0,
      height: orientation == Orientation.portrait ? 360.0 : 200.0,
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          var iconData = widget.icons[index];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIconData = iconData.codePoint;
                });
                widget.onIconChanged(iconData);
              },
              borderRadius: BorderRadius.circular(50.0),
              child: IconDisplay(
                codePoint: iconData.codePoint,
                fontFamily: widget.fontFamily,
                outlineColor: iconData.codePoint == selectedIconData
                    ? widget.highlightColor
                    : widget.outlineColor,
              ),
            ),
          );
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: orientation == Orientation.portrait ? 4 : 6,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: widget.icons.length,
      ),
    );
  }
}
