import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

import '../schoolloop/schoolloop.dart';
import '../schoolloop/schoolloop_library.dart';
import '../shared_widgets.dart' as shared;
import '../themes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GlobalKey<AutoCompleteTextFieldState<School>> key =
      new GlobalKey<AutoCompleteTextFieldState<School>>();

  AutoCompleteTextField _schoolNameTextField;
  TextEditingController _usernameController;
  TextEditingController _passwordController;

  LoginPageState();

  @override
  void initState() {
    SchoolLoop.sharedInstance.fetchSchools();
    _schoolNameTextField = AutoCompleteTextField<School>(
      onFocusChanged: (hasFocus) {},
      suggestions: SchoolLoop.sharedInstance.schoolList,
      decoration: new InputDecoration(
        border: InputBorder.none,
        contentPadding: EdgeInsets.all(10.0),
        icon: Icon(FontAwesomeIcons.school),
        hintText: 'School Name',
      ),
      key: key,
      clearOnSubmit: false,
      submitOnSuggestionTap: true,
      itemBuilder: (context, School item) => Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(item.name),
          ),
      itemSorter: (a, b) => a.name.compareTo(b.name),
      itemFilter: (School item, String query) =>
          item.name.toLowerCase().startsWith(query.toLowerCase()),
      itemSubmitted: (_) => {},
    );

    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    tryLogin(context);
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _schoolNameTextField.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundBoxDecor,
      padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: Column(
            children: <Widget>[
              shared.icon,
              TextField(
                autofocus: false,
                autocorrect: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(FontAwesomeIcons.user),
                  hintText: 'Username',
                  hintStyle: TextStyle(fontFamily: 'WorkSansSemiBold'),
                ),
                controller: _usernameController,
              ),
              TextField(
                autofocus: false,
                obscureText: true,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(FontAwesomeIcons.lock),
                  hintText: 'Password',
                  hintStyle: TextStyle(fontFamily: 'WorkSansSemiBold'),
                ),
                controller: _passwordController,
              ),
              _schoolNameTextField,
              Padding(
                padding: EdgeInsets.symmetric(vertical: 160.0),
                child: RaisedButton(
                  padding: EdgeInsets.all(0),
                  child: Container(
                    color: ThemeColors.primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    child: Text(
                      'Log in',
                      style: TextStyle(color: ThemeColors.backgroundColor),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      if (await SchoolLoop.sharedInstance.login(
                          schoolName:
                              _schoolNameTextField.textField.controller.text,
                          username: _usernameController.text,
                          password: _passwordController.text)) {
                        await successfullLogin(context);
                      }
                    } catch (exception) {
                      if (exception is HttpException &&
                          exception.message == '401')
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Incorrect Password'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('Close'),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ],
                              ),
                        );
                    }
                  },
                ),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  static Future<bool> tryLogin(context,
      [bool isFromLoadingPage = false]) async {
    if (await SchoolLoop.sharedInstance.savedLogin()) {
      successfullLogin(context, isFromLoadingPage);
      return true;
    }
    return false;
  }

  static Future<void> successfullLogin(BuildContext context,
      [bool isFromLoadingPage = false]) async {
    if (!isFromLoadingPage) Navigator.pushNamed(context, '/loading');
    await SchoolLoop.sharedInstance.fetchCourses();
    await SchoolLoop.sharedInstance.fetchAssignments();
    await SchoolLoop.sharedInstance.fetchGrades();
    await SchoolLoop.sharedInstance.fetchNews();
    if (!isFromLoadingPage) {
      //Navigator.maybePop(context);
      Navigator.pushReplacementNamed(context, '/logged_in');
    }
  }
}
