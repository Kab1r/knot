import 'package:flutter/material.dart';

import 'package:rounded_floating_app_bar/rounded_floating_app_bar.dart';

import '../schoolloop/course.dart';
import '../schoolloop/grade.dart';
import '../shared_widgets.dart';
import '../themes.dart';

class CourseDetailsPage extends StatefulWidget {
  final Course course;
  CourseDetailsPage(this.course);

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
        padding: EdgeInsets.fromLTRB(1.0, 5.0, 1.0, 1.0),
        child: NestedScrollView(
          headerSliverBuilder: (context, isInnerBoxScroll) => [
                RoundedFloatingAppBar(
                  backgroundColor: ThemeColors.backgroundColor,
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
                      Container(
                        child: icon,
                        constraints: BoxConstraints(maxHeight: 40),
                      ),
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
              Navigator.of(context).pushNamed('/grade', arguments: this.grade);
            }),
        child: Card(
          color: (grade.isZero)
              ? Colors.red
              : ThemeColors.backgroundColor,
          child: Container(
            padding: EdgeInsets.all(4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  //width: getTextWidth(context) / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.grade.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        this.grade.categoryName,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          this.grade.percentScore,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(this.grade.score + '/' + this.grade.maxPoints),
                      ],
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
