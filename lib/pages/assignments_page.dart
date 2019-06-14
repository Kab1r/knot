import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../schoolloop/assignment.dart';
import '../schoolloop/schoolloop.dart';
import '../themes.dart';

Assignment currentAssignment;

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
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
    return Container(
      padding: EdgeInsets.fromLTRB(5, 25, 5, 5),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropMaterialHeader(
          backgroundColor: primaryTheme.primaryColor,
        ),
        controller: _refreshController,
        onLoading: () => setState(() async {
              await SchoolLoop.sharedInstance.fetchAssignments();
              _refreshController.loadComplete();
            }),
        onRefresh: () => _refreshController.refreshCompleted(),
        child: ListView.builder(
          itemCount: SchoolLoop.sharedInstance.assignments.length,
          itemBuilder: (_, int index) =>
              AssignmentWidget(SchoolLoop.sharedInstance.assignments[index]),
        ),
      ),
    );
  }
}

class AssignmentWidget extends StatefulWidget {
  final Assignment assignment;

  AssignmentWidget(this.assignment);

  @override
  _AssignmentWidgetState createState() => _AssignmentWidgetState(assignment);
}

class _AssignmentWidgetState extends State<AssignmentWidget> {
  final Assignment assignment;

  _AssignmentWidgetState(this.assignment);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () => setState(() {
              currentAssignment = this.assignment;
              Navigator.of(context).pushNamed('/assignment');
            }),
        child: Card(
          color: primaryTheme.backgroundColor,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      assignment.title,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryTheme.accentColor,
                      ),
                    ),
                    Text(
                      assignment.courseName,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: primaryTheme.accentColor,
                      ),
                    ),
                  ],
                ),
              ),
              Material(
                color: Colors.transparent,
                child: Icon(
                  Icons.chevron_right,
                  color: primaryTheme.accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
