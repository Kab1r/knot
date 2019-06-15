import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../preferences.dart';
import 'schoolloop_library.dart';

class SchoolLoop {
  static var sharedInstance = SchoolLoop();

  var keychain = FlutterSecureStorage();

  var schoolList = List<School>();

  School _school;
  Account account;

  var courses = List<Course>();
  var assignments = List<Assignment>();
  var news = List<News>();

  Future<void> fetchSchools() async => schoolList = await Bus.fetchSchoolList();

  School _findSchool(String schoolName) => schoolList
      .firstWhere((possibleSchool) => schoolName == possibleSchool.name);

  Future<bool> login(
      {String schoolName, String username, String password}) async {
    if (schoolName == null || schoolName == '')
      _school = await Preferences.getSchool();
    else _school = _findSchool(schoolName);
    if (username == null || username == '')
      username = await Preferences.getUsername();
    if (password == null || password == '')
      password = await this.keychain.read(key: username);
    if (_school == null) return false;
    account = await Bus.login(_school.domainName, username, password);
    if (account == null) return false;
    keychain.write(key: username, value: password);
    return true;
  }

  void logOut() {
    keychain.delete(key: account.username);
    Preferences.clearAll();
    sharedInstance = SchoolLoop();
  }

  Future<void> fetchCourses() async =>
      courses = await Bus.fetchCourses(_school.domainName, account);

  Future<void> fetchAssignments() async =>
      assignments = await Bus.fetchAssignments(_school.domainName, account);

  Future<void> fetchGrades() async {
    await Bus.fetchGrades(courses, account, _school.domainName);
  }

  Future<void> fetchNews() async =>
      news = await Bus.fetchNews(_school.domainName, account);
}
