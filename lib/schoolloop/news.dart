class News {
  String title;
  String authorName;
  DateTime createdDate;
  String description; // HTML
  Map<String, Uri> links;
  String iD;

  News.fromJson(Map<String, dynamic> json) {
    this.title = json['title'] ?? '';
    this.authorName = json['authorName'] ?? '';
    this.createdDate =
        DateTime.fromMillisecondsSinceEpoch(int.parse(json['createdDate']));
    this.description = json['description'] ?? '';
    this.iD = (json['iD'] ?? '0');
  }
}
