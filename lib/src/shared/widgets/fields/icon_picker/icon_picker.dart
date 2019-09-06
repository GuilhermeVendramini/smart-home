import 'package:flutter/material.dart';

import 'icon_display.dart';

class IconPicker extends StatefulWidget {
  final ValueChanged<IconData> onIconChanged;
  final IconData currentIconData;
  final Color highlightColor;
  final String fontFamily;
  final List<IconData> icons;

/*  final List<IconData> icons = [
    SmartHomeIcons.house,
    SmartHomeIcons.alarmclock,
    SmartHomeIcons.aquarium,
    SmartHomeIcons.armchair,
    SmartHomeIcons.basin,
    SmartHomeIcons.bathtub,
    SmartHomeIcons.bed,
    SmartHomeIcons.bookshelf,
    SmartHomeIcons.cactus,
    SmartHomeIcons.candles,
    SmartHomeIcons.carpet,
    SmartHomeIcons.clock,
    SmartHomeIcons.cuckoo,
    SmartHomeIcons.cushion,
    SmartHomeIcons.desk,
    SmartHomeIcons.desklamp,
    SmartHomeIcons.desk_light,
    SmartHomeIcons.door,
    SmartHomeIcons.doorhandle,
    SmartHomeIcons.drawer,
    SmartHomeIcons.dresser,
    SmartHomeIcons.fence,
    SmartHomeIcons.fireplace,
    SmartHomeIcons.floorlamp,
    SmartHomeIcons.flowers,
    SmartHomeIcons.globe,
    SmartHomeIcons.hanger,
    SmartHomeIcons.homecinema,
    SmartHomeIcons.hourglass,
    SmartHomeIcons.house,
    SmartHomeIcons.lamp,
    SmartHomeIcons.light,
    SmartHomeIcons.lights,
    SmartHomeIcons.livingroom,
    SmartHomeIcons.mirror,
    SmartHomeIcons.outlet,
    SmartHomeIcons.painting,
    SmartHomeIcons.plant,
    SmartHomeIcons.refrigerator,
    SmartHomeIcons.shower,
    SmartHomeIcons.sofa,
    SmartHomeIcons.stairs,
    SmartHomeIcons.table,
    SmartHomeIcons.toilet,
    SmartHomeIcons.towel,
    SmartHomeIcons.tv,
    SmartHomeIcons.vase,
    SmartHomeIcons.wallclock,
    SmartHomeIcons.wallpaper,
    SmartHomeIcons.wardrobe,
    SmartHomeIcons.window,
  ];*/

  IconPicker({
    @required this.currentIconData,
    @required this.onIconChanged,
    @required this.fontFamily,
    @required this.icons,
    Color highlightColor,
  }) : this.highlightColor = highlightColor ?? Colors.blue;

  @override
  State<StatefulWidget> createState() {
    return _IconPickerState();
  }
}

class _IconPickerState extends State<IconPicker> {
  IconData selectedIconData;

  @override
  void initState() {
    selectedIconData = widget.currentIconData;
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
                  selectedIconData = iconData;
                });
                widget.onIconChanged(iconData);
              },
              borderRadius: BorderRadius.circular(50.0),
              child: IconDisplay(
                codePoint: iconData.codePoint,
                fontFamily: widget.fontFamily,
                outlineColor:
                    iconData == selectedIconData ? widget.highlightColor : null,
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
