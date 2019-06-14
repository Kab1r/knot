class Account {
  String username;
  String password;
  String fullName;
  String studentID;
  String hashedPassword;
  String email;

  Account({
    this.username = '',
    this.password = '',
    this.fullName = '',
    this.studentID = '',
    this.hashedPassword = '',
    this.email = '',
  });

  Account.login(String username, String password, Map<String, dynamic> json) {
    this.username = username;
    this.password = password;
    this._fromJson(json);
  }

  void _fromJson(Map<String, dynamic> json) {
    this.fullName = json['fullName'] ?? '';
    this.studentID = json['userID'] ?? '';
    this.hashedPassword = json['hashedPassword'] ?? '';
    this.email = json['email'] ?? '';
  }

  @override
  String toString() {
    return 'username: $username, fullName: $fullName, studentID: $studentID, email: $email';
  }
}
