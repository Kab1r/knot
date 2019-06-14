class Cutoff {
  String name;
  String start;

  Cutoff({this.name = '', this.start = ''});

  Cutoff.fromJson(Map<String, dynamic> json) {
    this.name = json['name'] ?? '';
    this.start = json['start'] ?? '';
  }
}
