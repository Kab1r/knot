import 'package:flutter/material.dart';

import '../schoolloop/assignment.dart';
import '../schoolloop/schoolloop.dart';
import '../themes.dart';

class AssignmentsPage extends StatefulWidget {
  @override
  _AssignmentsPageState createState() => _AssignmentsPageState();
}

class _AssignmentsPageState extends State<AssignmentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 25, 5, 5),
      child: RefreshIndicator(
        onRefresh: () async {
          await SchoolLoop.sharedInstance.fetchAssignments();
          setState(() {});
        },
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
              Navigator.of(context)
                  .pushNamed('/assignment', arguments: this.assignment);
            }),
        child: Card(
          color: ThemeColors.backgroundColor,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        assignment.title,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        assignment.courseName + ' - ' + assignment.categoryName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    'Points',
                    style: TextStyle(fontSize: 8),
                  ),
                  Text(
                    assignment.maxPoints ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: Icon(
                  Icons.chevron_right,
                  color: ThemeColors.accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
