import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../schoolloop/course.dart';
import '../schoolloop/schoolloop.dart';
import '../themes.dart';

bool isHidden = false;

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => isHidden = !isHidden),
        label: Text((isHidden) ? 'Unhide' : 'Hide'),
        icon:
            Icon((isHidden) ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash),
        backgroundColor: ThemeColors.primaryColor,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 25, 5, 5),
        child: RefreshIndicator(
          onRefresh: () async {
            await SchoolLoop.sharedInstance.fetchCourses();
            await SchoolLoop.sharedInstance.fetchGrades();
            setState(() {});
          },
          child: ListView.builder(
              itemCount: SchoolLoop.sharedInstance.courses.length,
              itemBuilder: (_, int index) {
                return _CourseWidget(SchoolLoop.sharedInstance.courses[index]);
              }),
        ),
      ),
    );
  }
}

class _CourseWidget extends StatefulWidget {
  final Course course;

  _CourseWidget(
    this.course,
  );

  @override
  __CourseWidgetState createState() {
    return __CourseWidgetState(course);
  }
}

class __CourseWidgetState extends State<_CourseWidget> {
  final Course course;

  __CourseWidgetState(this.course);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: GestureDetector(
          onTap: () => setState(() {
                Navigator.of(context).pushNamed('/course', arguments: this.course);
              }),
          child: Card(
            color: ThemeColors.backgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 10.0,
                          backgroundColor: ThemeColors.accentColor,
                          child: Container(
                            padding: const EdgeInsets.all(1),
                            child: Text(
                              course.period,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                course.courseName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(course.teacherName),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          (isHidden) ? '' : course.grade,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text((isHidden) ? 'Hidden' : course.score),
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
