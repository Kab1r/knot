import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'themes.dart';
import 'router.dart' as router;

void main() async =>
  runApp(KnotApp());


class KnotApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark
        .copyWith(statusBarColor: ThemeColors.backgroundColor));
    return MaterialApp(
      title: 'Knot',
      theme: appTheme,
      initialRoute: '/',
      onGenerateRoute: router.generateRoute,
    );
  }
}
