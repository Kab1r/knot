import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes.dart';
import 'assignments_page.dart';
import 'courses_page.dart';
import 'news_page.dart';

class LoggedInPage extends StatefulWidget {
  @override
  _LoggedInPageState createState() => _LoggedInPageState();
}

class _LoggedInPageState extends State<LoggedInPage> {
  FancyBottomNavigation bottomNavigation;
  var controller = PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(5),
        child: PageView(
          controller: controller,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            AssignmentsPage(),
            CoursesPage(),
            NewsPage(),
          ],
        ),
      ),
      bottomNavigationBar: bottomNavigation = FancyBottomNavigation(
        tabs: [
          TabData(iconData: Icons.assignment, title: 'Assignments'),
          TabData(iconData: Icons.dashboard, title: 'Courses'),
          TabData(iconData: CupertinoIcons.news_solid, title: 'News'),
        ],
        initialSelection: 0,
        onTabChangedListener: (position) => setState(() {
              controller.animateToPage(position,
                  duration: Duration(milliseconds: 300), curve: Curves.ease);
            }),
        inactiveIconColor: primaryTheme.accentColor,
        activeIconColor: primaryTheme.primaryColor,
        circleColor: primaryTheme.backgroundColor,
      ),
    );
  }
}
