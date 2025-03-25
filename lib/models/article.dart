class Article {
  final String id;
  final String title;
  final String author;
  final String date;
  final String content;
  final String imageUrl;
  final List<String> tags;

  Article({
    required this.id,
    required this.title,
    required this.author,
    required this.date,
    required this.content,
    required this.imageUrl,
    required this.tags,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      date: json['date'],
      content: json['content'],
      imageUrl: json['imageUrl'],
      tags: List<String>.from(json['tags']),
    );
  }
}