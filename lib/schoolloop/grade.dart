class Grade {
  String title;
  String categoryName;
  String percentScore;
  String score;
  String maxPoints;
  String comment;
  String systemID;
  String dueDate;
  String changedDate;
  String submissionTitle;
  bool isSubmissionlate;

  Grade(
      {this.title = '',
      this.categoryName = '',
      this.percentScore = '',
      this.score = '',
      this.maxPoints = '',
      this.comment = '',
      this.systemID = '',
      this.dueDate = '',
      this.changedDate = '',
      this.submissionTitle = '',
      this.isSubmissionlate = false});

  Grade.fromJson(Map<String, dynamic> json) {
    this.title = json['title'] ?? '';
    this.categoryName = json['categoryName'] ?? '';
    this.percentScore = json['percentScore'] ?? '';
    this.score = json['score'] ?? '';
    this.maxPoints = json['maxPoints'] ?? '';
    this.comment = json['comment'] ?? '';
    this.systemID = json['systemID'] ?? '';
    this.dueDate = json['dueDate'] ?? '';
    this.changedDate = json['changedDate'] ?? '';
    this.submissionTitle =
        (json['submission'] ?? Map<String, dynamic>())['fileName'] ??
            'No Submition';
    this.isSubmissionlate =
        ((json['submission'] ?? Map<String, dynamic>())['late'] ?? '')
                .toLowerCase() ==
            'true';
  }
}
