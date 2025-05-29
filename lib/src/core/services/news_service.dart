import 'package:flashfeed/src/data/models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsService {
  Future<NewsApiResponse> fetchNews(String apiUrl) async {
    if (apiUrl.isEmpty) {
      return NewsApiResponse(message: "API URL is empty", total: 0, data: []);
    }
    try {
      final response = await http
          .get(Uri.parse(apiUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return NewsApiResponse.fromJson(
          json.decode(utf8.decode(response.bodyBytes)),
        );
      } else {
        throw Exception('Gagal memuat berita (Status: ${response.statusCode})');
      }
    } catch (e) {
      throw Exception(
        'Gagal memuat berita: Terjadi kesalahan jaringan atau parsing.',
      );
    }
  }
}
