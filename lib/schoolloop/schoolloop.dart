import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../preferences.dart';
import 'schoolloop_library.dart';

class SchoolLoop {
  static var sharedInstance = SchoolLoop();

  var keychain = FlutterSecureStorage();

  var schoolList = List<School>();

  School school;
  Account account;

  var courses = List<Course>();
  var assignments = List<Assignment>();
  var news = List<News>();

  Future<void> fetchSchools() async => schoolList = await Bus.fetchSchoolList();

  School _findSchool(String schoolName) =>
      schoolList
          .firstWhere((possibleSchool) => schoolName == possibleSchool.name) ??
      null;

  Future<bool> login(
      {String schoolName, String username, String password}) async {
    //if (await this.savedLogin()) return true;

    if (schoolName == null || schoolName.isEmpty)
      schoolName = await Preferences.getSchoolName();
    if (schoolName == null || schoolName.isEmpty) return false;

    if (username == null || username.isEmpty)
      username = await Preferences.getUsername();
    if (username == null || username.isEmpty) return false;

    if (password == null || password.isEmpty)
      password = await this.keychain.read(key: username);
    if (password == null || password.isEmpty) return false;

    await fetchSchools();
    School possibleSchool = _findSchool(schoolName);
    if (possibleSchool.isNullOrEmpty()) return false;

    account = await Bus.login(possibleSchool.domainName, username, password);
    if (account.isNullOrEmpty())
      return false;
    else
      school = possibleSchool;

    keychain.write(key: username, value: account.password);
    Preferences.setUsername(username);
    Preferences.setSchoolName(schoolName);
    Preferences.setIsHidden(false);
    return true;
  }

  Future<bool> savedLogin() async {
    final savedUsername = await Preferences.getUsername();
    if (savedUsername == null || savedUsername.isEmpty) return false;
    final savedPassword = await keychain.read(key: savedUsername);
    if (savedPassword == null || savedPassword.isEmpty) return false;
    final savedSchoolName = await Preferences.getSchoolName();
    if (savedSchoolName == null || savedSchoolName.isEmpty) return false;

    await fetchSchools();
    School possibleSchool = _findSchool(savedSchoolName);
    if (possibleSchool.isNullOrEmpty()) return false;

    Account possibleAccount = await Bus.login(
        possibleSchool.domainName, savedUsername, savedPassword);
    if (possibleAccount.isNullOrEmpty()) return false;

    school = possibleSchool;
    account = possibleAccount;
    return true;
  }

  Future<void> logOut() async {
    try {
      await keychain.delete(key: account.username);
    } catch (ignored) {}

    await Preferences.clearAll();
    sharedInstance = SchoolLoop();
  }

  Future<void> fetchCourses() async =>
      courses = await Bus.fetchCourses(school.domainName, account);

  Future<void> fetchAssignments() async =>
      assignments = await Bus.fetchAssignments(school.domainName, account);

  Future<void> fetchGrades() async => // also sets schoolID for account
      await Bus.fetchGrades(courses, account, school.domainName);

  Future<void> fetchNews() async =>
      news = await Bus.fetchNews(school.domainName, account);

  Future<void> refreshAll() async {
    await fetchSchools();
    await fetchAssignments();
    await fetchCourses();
    await fetchGrades();
    await fetchNews();
  }
}
