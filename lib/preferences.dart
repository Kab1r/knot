
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static Future<bool> getIsHidden() async =>
      (await SharedPreferences.getInstance()).getBool('isHidden') ?? false;

  static Future<void> setIsHidden(bool value) async =>
      (await SharedPreferences.getInstance()).setBool('isHidden', value);


  static Future<String> getSchoolName() async => (await SharedPreferences.getInstance()).getString('schoolName') ?? '';

  static Future<void> setSchoolName(String value) async => (await SharedPreferences.getInstance()).setString('schoolName', value);


  static Future<String> getUsername() async =>
      (await SharedPreferences.getInstance()).getString('username') ?? '';

  static Future<void> setUsername(String value) async =>
      (await SharedPreferences.getInstance()).setString('username', value);

  static Future<void> clearAll() async =>
  (await SharedPreferences.getInstance()).clear();
}
