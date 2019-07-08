import 'package:flutter_udid/flutter_udid.dart';
class Constants {
  static final String version = '3';
  static final String devToken = '';
  static final String devOS = 'Flutter-Dart!';
  static final String year = DateTime.now().year.toString();
  static final _genericAuthority = 'lol.schoolloop.com';
  static final _mailPath = 'mapi/mail_messages';

  static Uri forgotUrl() =>
      Uri.https(_genericAuthority, 'portal/forgot_password');

  static Uri schoolsUrl() => Uri.https(_genericAuthority, 'mapi/schools');

  static Future<Uri> loginUrl(String domainName) async => Uri.https(domainName, 'mapi/login',
      {'version': version, 'devToken': devToken, 'devOS': devOS, 'year': year, 'uuid': await FlutterUdid.udid});

  static Uri courseUrl(String domainName, String studentID) =>
      Uri.https(domainName, 'mapi/report_card', {'studentID': studentID});

  static Uri assignmentUrl(String domainName, String studentID) =>
      Uri.https(domainName, 'mapi/assignments', {'studentID': studentID});

  static Uri gradeUrl(String domainName, String studentID, String periodID) =>
      Uri.https(domainName, 'mapi/progress_report',
          {'studentID': studentID, 'periodID': periodID});

  static Uri newsUrl(String domainName, String studentID) =>
      Uri.https(domainName, 'mapi/news', {'studentID': studentID});

  static Uri lockerUrl(String domainName, String username,
          {String path = ''}) =>
      Uri.https('webdav-$domainName', 'users/$username$path');

  static Uri loopMailUrl(String domainName, String studentID) =>
      Uri.https(domainName, _mailPath, {'studentID': studentID});

  static Uri loopMailMessageUrl(
          String domainName, String studentID, String messageID) =>
      Uri.https(
          domainName, _mailPath, {'studentID': studentID, 'ID': messageID});

  static Uri loopMailContactsUrl(
          String domainName, String studentID, String query) =>
      Uri.https(
          domainName, 'mapi/contacts', {'studentID': studentID, 'q': query});

  static Uri loopMailSendUrl(String domainName) =>
      Uri.https(domainName, _mailPath);
}
