import 'package:intl/intl.dart';

import 'category.dart';
import 'cutoff.dart';
import 'grade.dart';
import 'trend_score.dart';

class Course {
  String courseName;
  String period;
  String teacherName;
  String grade;
  String score;
  String periodID;
  DateTime lastUpdated;
  static DateFormat dateFormatter = DateFormat('M/d/yy h:mm a', 'en_US');

  var cutoffs = List<Cutoff>();
  var categories = List<Category>();
  var grades = List<Grade>();
  var trendScores = List<TrendScore>();
  int precision = 0;

  void setPrecision(String precision) {
    this.precision = int.parse(precision);
  }

  Grade findGrade(String systemID) =>
      grades.firstWhere((grade) => systemID == grade.systemID);

  Course.fromJson(Map<String, dynamic> json) {
    this.courseName = json['courseName'] ?? '';
    this.period = json['period'] ?? '';
    this.teacherName = json['teacherName'] ?? '';
    this.grade = json['grade'] ?? '';
    this.score = json['score'] ?? '';
    this.periodID = json['periodID'] ?? '';
    this.lastUpdated = dateFormatter.parse(json['lastUpdated']);
    this.setPrecision(json['precision'] ?? '0');
  }

  void gradesFromJson(List<dynamic> json) {
    this.grades = List<Grade>();
    json.forEach((jsonGrade) => grades.add(Grade.fromJson(jsonGrade)));
  }

  void cutoffsFromJson(List<dynamic> json) {
    this.cutoffs = List<Cutoff>();
    json.forEach((jsonCutoff) => cutoffs.add(Cutoff.fromJson(jsonCutoff)));
  }

  void categoriesFromJson(List<dynamic> json) {
    this.categories = List<Category>();
    json.forEach(
        (jsonCategory) => categories.add(Category.fromJson(jsonCategory)));
  }

  void trendScoresFromJson(List<dynamic> json) {
    this.trendScores = List<TrendScore>();
    json.forEach((jsonTrendScore) =>
        trendScores.add(TrendScore.fromJson(jsonTrendScore)));
  }
}
