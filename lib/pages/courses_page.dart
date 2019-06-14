import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../schoolloop/course.dart';
import '../schoolloop/schoolloop.dart';
import '../themes.dart';

Course currentCourse;
bool isHidden = false;

class CoursesPage extends StatefulWidget {
  @override
  _CoursesPageState createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => setState(() => isHidden = !isHidden),
        label: Text((isHidden) ? 'Unhide' : 'Hide'),
        icon: Icon(Icons.remove_red_eye),
        backgroundColor: primaryTheme.backgroundColor,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(5, 25, 5, 5),
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: WaterDropMaterialHeader(
            backgroundColor: primaryTheme.primaryColor,
          ),
          controller: _refreshController,
          onLoading: () => setState(() async {
                await SchoolLoop.sharedInstance.fetchCourses();
                _refreshController.loadComplete();
              }),
          onRefresh: () => _refreshController.refreshCompleted(),
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
      child: GestureDetector(
        onTap: () => setState(() {
              currentCourse = this.course;
              Navigator.of(context).pushNamed('/course');
            }),
        child: Card(
          color: primaryTheme.backgroundColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(course.period),
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
              Row(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        (isHidden) ? 'Hidden' : course.grade,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text((isHidden) ? 'Hidden' : course.score),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.chevron_right),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
