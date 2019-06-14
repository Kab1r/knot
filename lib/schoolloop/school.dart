class School {
  String name;
  String domainName;
  String districtName;

  School({this.name = '', this.domainName = '', this.districtName = ''});

  School.fromJson(Map<String, dynamic> json) {
    this.name = json['name'] ?? '';
    this.domainName = json['domainName'] ?? '';
    this.districtName = json['districtName'] ?? '';
  }

  @override
  String toString() => this.name;
}
