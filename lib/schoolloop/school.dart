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

  Map<String, dynamic> toJson() => {
        'name': this.name,
        'domainName': this.domainName,
        'districtName': this.districtName,
      };

  @override
  String toString() => this.name;

  bool isNullOrEmpty() =>
      this == null ||
      this.name.isEmpty ||
      this.districtName.isEmpty ||
      this.domainName.isEmpty;
}
