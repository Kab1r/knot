import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../schoolloop/schoolloop.dart';
import '../schoolloop/schoolloop_library.dart';
import '../shared_widgets.dart' as shared;
import '../themes.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<AutoCompleteTextFieldState<School>> key =
      new GlobalKey<AutoCompleteTextFieldState<School>>();

  AutoCompleteTextField _schoolNameTextField;

  _LoginPageState();

  @override
  void initState() {
    _schoolNameTextField = AutoCompleteTextField<School>(
      suggestions: SchoolLoop.sharedInstance.schoolList,
      decoration: new InputDecoration(
        contentPadding: EdgeInsets.all(10.0),
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _usernameController = TextEditingController();
    final _passwordController = TextEditingController();

    return Container(
      decoration: backgroundBoxDecor,
      padding: EdgeInsets.fromLTRB(5, 30, 5, 0),
      child: Center(
        child: Column(
          children: <Widget>[
            shared.icon,
            CupertinoTextField(
              autofocus: false,
              autocorrect: false,
              placeholder: 'Username',
              controller: _usernameController,
            ),
            CupertinoTextField(
              autofocus: false,
              obscureText: true,
              placeholder: 'Password',
              controller: _passwordController,
            ),
            Material(
              child: _schoolNameTextField,
              color: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 160.0),
              child: RaisedButton(
                padding: EdgeInsets.all(0),
                child: Container(
                  color: primaryTheme.primaryColor,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  child: Text(
                    'Log in',
                    style: TextStyle(color: primaryTheme.backgroundColor),
                  ),
                ),
                onPressed: () async {
                  if (await SchoolLoop.sharedInstance.login(
                      _schoolNameTextField.textField.controller.text,
                      _usernameController.text,
                      _passwordController.text)) {
                    Navigator.of(context).pushNamed('/loading');
                    await SchoolLoop.sharedInstance.fetchCourses();
                    await SchoolLoop.sharedInstance.fetchAssignments();
                    await SchoolLoop.sharedInstance.fetchGrades();
                    await SchoolLoop.sharedInstance.fetchNews();
                    await Navigator.pushNamed(context, '/logged_in');
                  }
                },
              ),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.start,
        ),
      ),
    );
  }
}
