class Grade {
  String title;
  String categoryName;
  String percentScore;
  String score;
  String maxPoints;
  bool isZero;
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
      this.isZero = false,
      this.comment = '',
      this.systemID = '',
      this.dueDate = '',
      this.changedDate = '',
      this.submissionTitle = '',
      this.isSubmissionlate = false});

  Grade.fromJson(Map<String, dynamic> json) {
    this.title = json['assignment']['title'] ?? '';
    this.categoryName = json['assignment']['categoryName'] ?? '';
    this.percentScore = json['percentScore'] ?? '';
    this.score = json['score'] ?? '';
    this.maxPoints = json['assignment']['maxPoints'] ?? '';
    this.isZero = json['zero'] == 'true';
    this.comment = json['comment'] ?? '';
    this.systemID = json['assignment']['systemID'] ?? '';
    this.dueDate = json['assignment']['dueDate'] ?? '';
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
