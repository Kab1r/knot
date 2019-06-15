import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'schoolloop/schoolloop_library.dart';

class Preferences {
  static Future<bool> getIsHidden() async =>
      (await SharedPreferences.getInstance()).getBool('isHidden') ?? false;

  static Future<void> setIsHidden(bool value) async =>
      (await SharedPreferences.getInstance()).setBool('isHidden', value);

  static Future<School> getSchool() async => School.fromJson(
      json.decode((await SharedPreferences.getInstance()).getString('school') ?? '{}'));

  static Future<void> setSchool(School value) async =>
      json.encode((await SharedPreferences.getInstance())
          .setString('school', json.encode(value.toJson())));

  static Future<String> getUsername() async =>
      (await SharedPreferences.getInstance()).getString('username') ?? '';

  static Future<void> setUsername(String value) async =>
      (await SharedPreferences.getInstance()).setString('username', value);

  static Future<void> clearAll() async =>
  (await SharedPreferences.getInstance()).clear();
}
