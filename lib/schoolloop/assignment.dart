class Assignment {
  String title;
  String description;
  String courseName;
  String dueDate;
  Map<String, String> links;
  String iD;
  bool isCompleted = false;

  Assignment(
      {this.title = '',
      this.description = '',
      this.courseName = '',
      this.dueDate = '',
      this.links = const {'': ''},
      this.iD = ''});

  Assignment.fromJson(Map<String, dynamic> json) {
    this.title = json['title'] ?? '';
    this.description = json['description'] ?? '';
    this.courseName = json['courseName'] ?? '';
    this.dueDate = json['dueDate'] ?? '';
    this.links = json['links'] ?? const {'': ''};
    this.iD = json['iD'] ?? '';
  }

  DateTime getDueDate() {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(dueDate));
  }
}
