class Item {
  final String title;
  final String link;

  const Item({
    required this.title,
    required this.link,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      title: json['title'],
      link: json['link'],
    );
  }
}