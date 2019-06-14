import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../schoolloop/course.dart';
import '../schoolloop/grade.dart';
import '../themes.dart';
import 'courses_page.dart';

Grade currentGrade;

class CourseDetailsPage extends StatefulWidget {
  final Course course = currentCourse;

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState(this.course);
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  final Course course;

  _CourseDetailsPageState(this.course);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
        child: Column(
          children: <Widget>[
            Text(
              course.courseName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // TODO Graphs
            // Grades
            Center(
              child: ListView.builder(
                itemCount: this.course.grades.length,
                itemBuilder: (_, int index) =>
                    _GradeWidget(this.course.grades[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GradeWidget extends StatefulWidget {
  final Grade grade;

  _GradeWidget(this.grade);

  @override
  __GradeWidgetState createState() => __GradeWidgetState(this.grade);
}

class __GradeWidgetState extends State<_GradeWidget> {
  final Grade grade;

  __GradeWidgetState(this.grade);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => setState(() {
              currentGrade = this.grade;
              //Navigator.of(context).pushNamed('/grade'); // TODO
            }),
        child: Card(
          color: primaryTheme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(this.grade.title),
            ],
          ),
        ),
      ),
    );
  }
}
