class Article {
  final String id;
  final String title;
  final String? description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;
  final String? author;
  final String? sourceName;

  Article({
    required this.id,
    required this.title,
    this.description,
    required this.url,
    this.urlToImage,
    required this.publishedAt,
    this.content,
    this.author,
    this.sourceName,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['title'].hashCode
          .toString(), // Generate ID from title if not available
      title: json['title'] ?? 'No title',
      description: json['description'],
      url: json['url'] ?? '',
      urlToImage: json['urlToImage'],
      publishedAt: DateTime.parse(
        json['publishedAt'] ?? DateTime.now().toString(),
      ),
      content: json['content'],
      author: json['author'],
      sourceName: json['source'] is Map ? json['source']['name'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt.toIso8601String(),
      'content': content,
      'author': author,
      'sourceName': sourceName,
    };
  }
}
