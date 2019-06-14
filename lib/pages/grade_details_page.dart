import 'package:flutter/material.dart';

import '../schoolloop/grade.dart';
import 'course_details_page.dart';

class GradeDetailsPage extends StatefulWidget {
  final Grade grade = currentGrade;

  @override
  _GradeDetailsPageState createState() => _GradeDetailsPageState(this.grade);
}

class _GradeDetailsPageState extends State<GradeDetailsPage> {
  final Grade grade;

  _GradeDetailsPageState(this.grade);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: Column(
          children: <Widget>[
            Text(grade.title),
            Text(grade.categoryName),
            Text(grade.score + '/' + grade.maxPoints),
            Text(grade.percentScore),
            Text(grade.comment),
            Text(grade.submissionTitle)
          ],
        ),
      ),
    );
  }
}
