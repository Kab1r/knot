import 'package:flutter/foundation.dart';

class Account {
  String username;
  String password;
  String fullName;
  String studentID;
  String email;
  String schoolID;

  Account({
    this.username = '',
    this.password = '',
    this.fullName = '',
    this.studentID = '',
    this.email = '',
  });

  Account.login(String username, String password, Map<String, dynamic> json) {
    this.username = username;
    this.password = password;
    this._fromJson(json);
  }

  String setSchoolID(String value) => schoolID = value ?? schoolID ?? '';

  void _fromJson(Map<String, dynamic> json) {
    this.fullName = json['fullName'] ?? '';
    this.studentID = json['userID'] ?? '';
    this.email = json['email'] ?? '';
    if(json['hashedPassword'] != null && json['hashedPassword'] != 'null') {
      this.password = json['hashedPassword'];
    }
  }

  @override
  String toString() {
    return 'username: $username, fullName: $fullName, studentID: $studentID, email: $email';
  }

  bool isNullOrEmpty() =>
      this == null || username.isEmpty || password.isEmpty || studentID.isEmpty;
}
