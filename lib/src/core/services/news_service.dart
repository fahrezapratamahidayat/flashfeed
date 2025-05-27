import 'dart:convert';
import 'package:flashfeed/src/data/models/article.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _apiKey = 'YOUR_NEWS_API_KEY';
  static const String _baseUrl = 'https://newsapi.org/v2';

  // Singleton pattern
  static final NewsService _instance = NewsService._internal();
  factory NewsService() => _instance;
  NewsService._internal();

  // Get top headlines
  Future<List<Article>> getTopHeadlines({
    String? country,
    String? category,
    int page = 1,
    int pageSize = 20,
  }) async {
    final params = {
      'apiKey': _apiKey,
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      if (country != null) 'country': country,
      if (category != null) 'category': category,
    };

    final uri = Uri.parse(
      '$_baseUrl/top-headlines',
    ).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List;
        return articles.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load headlines: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch news: ${e.toString()}');
    }
  }

  // Search news
  Future<List<Article>> searchNews({
    required String query,
    String? sortBy,
    int page = 1,
    int pageSize = 20,
  }) async {
    final params = {
      'apiKey': _apiKey,
      'q': query,
      'page': page.toString(),
      'pageSize': pageSize.toString(),
      if (sortBy != null) 'sortBy': sortBy,
    };

    final uri = Uri.parse(
      '$_baseUrl/everything',
    ).replace(queryParameters: params);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final articles = data['articles'] as List;
        return articles.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Failed to search news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search news: ${e.toString()}');
    }
  }

  // Get news by category
  Future<List<Article>> getNewsByCategory(String category) async {
    return getTopHeadlines(
      country: 'id', // Indonesia (ubah sesuai kebutuhan)
      category: category,
    );
  }
}
