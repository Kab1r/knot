import 'package:flutter/material.dart';

import '../shared_widgets.dart' as shared;
import '../themes.dart';
import 'login_page.dart';

class LoadingPage extends StatelessWidget {
  final bool isNewLogin;

  const LoadingPage({Key key, this.isNewLogin=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isNewLogin)
      tryLogin(context);
    return Container(
      decoration: backgroundBoxDecor,
      child: Center(child: shared.icon),
    );
  }

  Future tryLogin (BuildContext context) async {
    if (!await LoginPageState.tryLogin(context, true))
      Navigator.pushReplacementNamed(context, '/login');
    else Navigator.pushReplacementNamed(context, '/logged_in');
  } 
}
