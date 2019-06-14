class Category {
  String name;
  String score;
  String weight;

  Category({this.name = '', this.score = '', this.weight = ''});

  Category.fromJson(Map<String, dynamic> json) {
    this.name = json['name'] ?? '';
    this.score = json['score'] ?? '';
    this.weight = json['weight'] ?? '';
  }
}
