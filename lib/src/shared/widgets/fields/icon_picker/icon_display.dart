import 'package:flutter/material.dart';

class IconDisplay extends StatelessWidget {
  final int codePoint;
  final Color outlineColor;

  IconDisplay({
    @required this.codePoint,
    Color outlineColor,
  }) : this.outlineColor = outlineColor ?? Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: outlineColor, width: 2.0),
      ),
      child: Icon(
        IconData(
          codePoint,
          fontFamily: 'SmartHomeIcons',
        ),
      ),
    );
  }
}
