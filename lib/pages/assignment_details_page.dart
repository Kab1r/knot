import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import '../schoolloop/assignment.dart';
import 'assignments_page.dart';

class AssignmentDetailsPage extends StatefulWidget {
  final Assignment assignment = currentAssignment;

  @override
  _AssignmentDetailsPageState createState() =>
      _AssignmentDetailsPageState(this.assignment);
}

class _AssignmentDetailsPageState extends State<AssignmentDetailsPage> {
  final Assignment assignment;

  _AssignmentDetailsPageState(this.assignment);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: Column(
          children: <Widget>[
            Text(
              assignment.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Html(
                data: assignment.description == 'null'
                    ? 'No Information Provided'
                    : assignment.description)
          ],
        ),
      ),
    );
  }
}
