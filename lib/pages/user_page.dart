import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../schoolloop/schoolloop_library.dart';
import '../themes.dart';

class UserPage extends StatelessWidget {
  final Account user = SchoolLoop.sharedInstance.account;
  final School school = SchoolLoop.sharedInstance.school;

  @override
  Widget build(BuildContext context) {
    final _split = user.fullName.split(', ');
    final _firstName = _split[1] ?? user.fullName;
    final _lastName = _split[0] ?? '';
    return Container(
      padding: EdgeInsets.fromLTRB(3.0, 25.0, 3.0, 3.0),
      child: Card(
        color: ThemeColors.backgroundColor,
        child: Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5.0),
                child: Hero(
                  child: Icon(
                    FontAwesomeIcons.userGraduate,
                    size: 60,
                  ),
                  tag: hashCode,
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    _firstName + ' ' + _lastName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Email: ' + user.email),
                  Text(school.districtName),
                  Text(school.name),
                  Text('School ID: ' + user.schoolID ?? 'none'),
                ],
              ),
              Container(
                child: OutlineButton(
                  shape: StadiumBorder(),
                  borderSide: BorderSide(color: ThemeColors.primaryColor,width: 1.5),
                  child: Text('Logout'),
                  onPressed: () async {
                    SchoolLoop.sharedInstance.logOut();
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
