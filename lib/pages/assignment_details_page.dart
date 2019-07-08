
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../schoolloop/assignment.dart';

class AssignmentDetailsPage extends StatelessWidget {
  final Assignment assignment;
  AssignmentDetailsPage(this.assignment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(5.0, 25, 5.0, 5.0),
        child: Card(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
            child: Center(
              child: Column(
                children: <Widget>[
                  Text(
                    this.assignment.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Html(
                      data: this.assignment.description == 'null'
                          ? 'No Information Provided'
                          : this.assignment.description.replaceAll('Â', ' '))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}