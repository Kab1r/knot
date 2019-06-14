import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'pages/assignment_details_page.dart';
import 'pages/course_details_page.dart';
import 'pages/loading_page.dart';
import 'pages/logged_in_pages.dart';
import 'pages/login_page.dart';
import 'schoolloop/schoolloop.dart';
import 'themes.dart';

void main() async {
  await SchoolLoop.sharedInstance.fetchSchools();
  runApp(KnotApp());
}

class KnotApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    '/login': (context) => LoginPage(),
    '/loading': (context) => LoadingPage(),
    '/logged_in': (context) => LoggedInPage(),
    '/assignment': (context) => AssignmentDetailsPage(),
    '/course': (context) => CourseDetailsPage(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: primaryTheme.backgroundColor));
    return MaterialApp(
      title: 'Knot',
      theme: primaryTheme,
      home: LoginPage(),
      routes: routes,
    );
  }
}
