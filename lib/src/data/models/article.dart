import 'dart:convert';

NewsApiResponse newsApiResponseFromJson(String str) =>
    NewsApiResponse.fromJson(json.decode(str));

String newsApiResponseToJson(NewsApiResponse data) =>
    json.encode(data.toJson());

class NewsApiResponse {
  final String message;
  final int total;
  final List<NewsArticle> data;

  NewsApiResponse({
    required this.message,
    required this.total,
    required this.data,
  });

  factory NewsApiResponse.fromJson(Map<String, dynamic> json) =>
      NewsApiResponse(
        message: json["message"] ?? "No message",
        total: json["total"] ?? 0,
        data: json["data"] == null
            ? []
            : List<NewsArticle>.from(
                json["data"].map((x) => NewsArticle.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "message": message,
    "total": total,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NewsArticle {
  final String title;
  final String link;
  final DateTime isoDate;
  final String image;
  final String description;

  NewsArticle({
    required this.title,
    required this.link,
    required this.isoDate,
    required this.image,
    required this.description,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) => NewsArticle(
    title: json["title"] ?? "No Title",
    link: json["link"] ?? "",
    isoDate: json["isoDate"] == null
        ? DateTime.now()
        : DateTime.tryParse(json["isoDate"]) ?? DateTime.now(),
    image: json["image"] ?? "",
    description: json["description"] ?? "No Description",
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "link": link,
    "isoDate": isoDate.toIso8601String(),
    "image": image,
    "description": description,
  };
}
