import 'package:flutter/material.dart';

import 'pages/assignment_details_page.dart';
import 'pages/course_details_page.dart';
import 'pages/grade_details_page.dart';
import 'pages/loading_page.dart';
import 'pages/logged_in_pages.dart';
import 'pages/login_page.dart';
import 'pages/news_details_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (context) => LoadingPage(isNewLogin: false));
    case '/loading':
      return MaterialPageRoute(builder: (context) => LoadingPage(isNewLogin: true));
    case '/logged_in':
      return MaterialPageRoute(builder: (context) => LoggedInPage());
    case '/assignment':
      return MaterialPageRoute(builder: (context) => AssignmentDetailsPage(settings.arguments));
    case '/course':
      return MaterialPageRoute(builder: (context) => CourseDetailsPage(settings.arguments));
    case '/grade':
      return MaterialPageRoute(builder: (context) => GradeDetailsPage(settings.arguments));
    case '/news':
      return MaterialPageRoute(builder: (context) => NewsDetailsPage(settings.arguments));
    case '/login':
    default:
      return MaterialPageRoute(builder: (context) => LoginPage());
  }
}
