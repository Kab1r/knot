import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

import '../schoolloop/course.dart';
import '../schoolloop/grade.dart';
import '../shared_widgets.dart';
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
      body: NestedScrollView(
        headerSliverBuilder: (context, isInnerBoxScroll) => [
              RoundedFloatingAppBar(
                backgroundColor: primaryTheme.backgroundColor,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
                floating: true,
                snap: true,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(child: icon, constraints: BoxConstraints(maxHeight: 40),),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        "Grades",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 20),
          child: ListView.builder(
            itemCount: this.course.grades.length,
            itemBuilder: (_, int index) =>
                _GradeWidget(this.course.grades[index]),
          ),
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
              Navigator.of(context).pushNamed('/grade'); // TODO
            }),
        child: Card(
          color: primaryTheme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8),
                    child: Text(
                      this.grade.title,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    this.grade.categoryName,
                    textAlign: TextAlign.left,
                  )
                ],
              ),
              Column(
                children: <Widget>[],
              ),
              Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
