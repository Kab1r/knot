class TrendScore {
  String score;
  String dayID;

  TrendScore({this.score = '', this.dayID = ''});

  DateTime getDate() => DateTime.fromMillisecondsSinceEpoch(int.parse(dayID));

  TrendScore.fromJson(Map<String, dynamic> json) {
    this.score = json['score'] ?? '';
    this.dayID = json['dayID'] ?? '';
  }
}
