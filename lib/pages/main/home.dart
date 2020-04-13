import 'package:eighttime/pages/main/dashboard/dashboard_screen.dart';
import 'package:eighttime/pages/main/qr_code/qr_code_screen.dart';
import 'package:eighttime/pages/main/settings/settings_screen.dart';
import 'package:eighttime/pages/main/sliding_up_panel/sliding_up_panel.dart';
import 'package:eighttime/pages/main/timeline/timeline_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex;
  bool _quickActivitiesPressed;
  PageController _pageController;
  PanelController _quickActivitiesController;

  @override
  void initState() {
    super.initState();

    _currentIndex = 0;
    _quickActivitiesPressed = false;
    _pageController = PageController();
    _quickActivitiesController = PanelController();
  }

  void closeQuickActivities([bool quickButton = false]) {
    if (!_quickActivitiesPressed && quickButton) {
      _quickActivitiesPressed = true;
      _quickActivitiesController.animatePanelToPosition(
        1.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    } else {
      _quickActivitiesPressed = false;
      _quickActivitiesController.animatePanelToPosition(
        0.0,
        duration: Duration(milliseconds: 500),
        curve: Curves.decelerate,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              children: <Widget>[
                DashboardScreen(),
                TimelineScreen(),
                QrCodeScreen(),
                SettingsScreen(),
              ],
            ),
            MySlidingUpPanel(
                quickActivitiesController: _quickActivitiesController),
          ],
        ),
        bottomNavigationBar: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 0.00),
                color: Colors.black.withOpacity(0.35),
                blurRadius: 3,
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Material(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _currentIndex = 0;
                      closeQuickActivities();
                      _pageController.jumpToPage(0);
                    });
                  },
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 5 - 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.equalizer,
                            color: _currentIndex == 0
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                        Text(
                          'Dashboard',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: _currentIndex == 0
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    setState(() => _currentIndex = 1);
                    closeQuickActivities();
                    _pageController.jumpToPage(1);
                  },
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 5 - 4,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: SvgPicture.asset(
                              "assets/bottom_bar/timeline.svg",
                              color: _currentIndex == 1
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey,
                              height: 24,
                              width: 24,
                            ),
                          ),
                          Text(
                            'Timeline',
                            style: TextStyle(
                                fontSize: 10.0,
                                color: _currentIndex == 1
                                    ? Theme.of(context).primaryColor
                                    : Colors.grey),
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                height: 55,
                color: Colors.white,
                width: MediaQuery.of(context).size.width / 5 + 16,
                child: OverflowBox(
                  maxHeight: 75,
                  child: Container(
                    height: 75,
                    child: Material(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12)),
                      color: _quickActivitiesPressed
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            closeQuickActivities(true);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          transform: Matrix4.translationValues(0, -3, 0),
                          child: SvgPicture.asset(
                            _quickActivitiesPressed
                                ? "assets/bottom_bar/chevron.svg"
                                : "assets/bottom_bar/flash.svg",
                            color: Colors.white,
                            height: 40,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    setState(() => _currentIndex = 2);
                    closeQuickActivities();
                    _pageController.jumpToPage(2);
                  },
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 5 - 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: SvgPicture.asset(
                            "assets/bottom_bar/qr_code.svg",
                            color: _currentIndex == 2
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        Text(
                          'QR Code',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: _currentIndex == 2
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    setState(() => _currentIndex = 3);
                    closeQuickActivities();
                    _pageController.jumpToPage(3);
                  },
                  child: Container(
                    height: 55,
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width / 5 - 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.settings,
                            color: _currentIndex == 3
                                ? Theme.of(context).primaryColor
                                : Colors.grey),
                        Text(
                          'Settings',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: _currentIndex == 3
                                  ? Theme.of(context).primaryColor
                                  : Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
