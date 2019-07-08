import 'package:flutter/material.dart';

import '../schoolloop/grade.dart';

class GradeDetailsPage extends StatelessWidget {
  final Grade grade;
  GradeDetailsPage(this.grade);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: Center(
                  child: Column(
            children: <Widget>[
              Text(grade.title, style: TextStyle(fontWeight: FontWeight.bold),),
              Text(grade.categoryName),
              Text(grade.score + '/' + grade.maxPoints),
              Text(grade.percentScore),
              Text(grade.comment),
              Text(grade.submissionTitle)
            ],
          ),
        ),
      ),
    );
  }
}
