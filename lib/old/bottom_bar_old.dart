import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBarOld extends StatefulWidget {
  BottomBarOld({Key key}) : super(key: key);

  @override
  _BottomBarOldState createState() => _BottomBarOldState();
}

class _BottomBarOldState extends State<BottomBarOld> {
  int _selectedIndex = 0;

  @override
  State<StatefulWidget> createState() {
    setState(() {
      _onItemTapped(0);
    });
    return null;
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index != 2) {
        _selectedIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.equalizer, color: Colors.black26),
          activeIcon:
              Icon(Icons.equalizer, color: Theme.of(context).primaryColor),
          title: Text('Dashboard',
              style: TextStyle(
                  fontSize: 10.0,
                  color: _selectedIndex != 0
                      ? Colors.black26
                      : Theme.of(context).primaryColor)),
        ),
        BottomNavigationBarItem(
            icon: SizedBox(
                child: SvgPicture.asset("assets/timeline.svg",
                    color: _selectedIndex != 1
                        ? Colors.black26
                        : Theme.of(context).primaryColor),
                height: 24,
                width: 24),
            title: Text('Timeline',
                style: TextStyle(
                    fontSize: 10.0,
                    color: _selectedIndex != 1
                        ? Colors.black26
                        : Theme.of(context).primaryColor))),
        BottomNavigationBarItem(
          icon: Icon(Icons.offline_bolt, color: Colors.black26),
          title: Text('Quick'),
        ),
        BottomNavigationBarItem(
            icon: ImageIcon(AssetImage("assets/qr_code.png"),
                color: Colors.black26),
            activeIcon: ImageIcon(
              AssetImage("assets/qr_code.png"),
              color: Theme.of(context).primaryColor,
            ),
            title: Text('TODO',
                style: TextStyle(
                    fontSize: 10.0,
                    color: _selectedIndex != 3
                        ? Colors.black26
                        : Theme.of(context).primaryColor))),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black26),
            activeIcon:
                Icon(Icons.settings, color: Theme.of(context).primaryColor),
            title: Text('Settings',
                style: TextStyle(
                    fontSize: 10.0,
                    color: _selectedIndex != 4
                        ? Colors.black26
                        : Theme.of(context).primaryColor))),
      ],
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.black26,
      unselectedFontSize: 10,
      selectedItemColor: Theme.of(context).primaryColor,
      selectedFontSize: 10,
      onTap: _onItemTapped,
    );
  }
}
