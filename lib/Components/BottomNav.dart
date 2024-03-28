import '/Config.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';

class BottomNavBar extends StatefulWidget {
  final Function()? notifyParent;

  const BottomNavBar({this.notifyParent});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Color bgColor = Colors.white;

  int _selectedIndex = 1;

  List<NavigationItem> items = [
    NavigationItem(
        const Icon(
          Icons.dashboard,
          size: 30,
        ),
        const Text("Dashboard"),
        kOrange),
    NavigationItem(
        const Icon(
          Icons.assistant_navigation,
          size: 30,
        ),
        const Text("Delivro"),
        kBase),
    NavigationItem(
        const Icon(
          Icons.settings,
          size: 30,
        ),
        const Text("Settings"),
        kOrange),
  ];

  Widget _buildItem(NavigationItem item, bool isSelected) {
    return AnimatedContainer(
      height: double.maxFinite,
      width: isSelected
          ? SizeConfig.imageSizeMultiplier * 32
          : SizeConfig.imageSizeMultiplier * 11,
      duration: isSelected ? const Duration(milliseconds: 200) : const Duration(seconds: 0),
      padding: EdgeInsets.all(kDefaultPadding / 2),
      decoration: BoxDecoration(
          color: isSelected ? item.color.withOpacity(.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(100)),
      child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            IconTheme(
              data: IconThemeData(
                  color:
                      isSelected ? item.color : Colors.black.withOpacity(.5)),
              child: item.icon,
            ),
            isSelected
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: DefaultTextStyle(
                      style: TextStyle(
                          color: isSelected ? item.color : Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: SizeConfig.heightMultiplier * 1.8),
                      child: item.text,
                    ),
                  )
                : Container()
          ],
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      color: Colors.white,
      padding: EdgeInsets.all(kDefaultPadding / 2),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items.map((item) {
            var itemIndex = items.indexOf(item);
            return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedIndex = itemIndex;
                    selectedTab = itemIndex;
                    widget.notifyParent;
                  });
                },
                child: _buildItem(
                    item, (_selectedIndex == itemIndex) ? true : false));
          }).toList()),
    );
  }
}

class NavigationItem {
  final Icon icon;
  final Text text;
  final Color color;

  NavigationItem(this.icon, this.text, this.color);
}
