import 'package:flashfeed/src/core/services/news_service.dart';
import 'package:flashfeed/src/data/models/article.dart';
import 'package:flutter/material.dart';
import 'news_list_item.dart';

enum NewsListStateValue { initial, loading, loaded, error, empty }

class NewsListView extends StatefulWidget {
  final String apiUrl;

  const NewsListView({super.key, required this.apiUrl});

  @override
  State<NewsListView> createState() => _NewsListViewState();
}

class _NewsListViewState extends State<NewsListView> {
  final NewsService _newsService = NewsService();
  NewsListStateValue _currentState = NewsListStateValue.initial;
  List<NewsArticle> _articles = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    if (widget.apiUrl.isNotEmpty) {
      _fetchNewsData(widget.apiUrl);
    }
  }

  @override
  void didUpdateWidget(NewsListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.apiUrl != oldWidget.apiUrl && widget.apiUrl.isNotEmpty) {
      _fetchNewsData(widget.apiUrl);
    }
  }

  Future<void> _fetchNewsData(String apiUrl) async {
    setState(() {
      _currentState = NewsListStateValue.loading;
      _articles = [];
      _errorMessage = '';
    });

    try {
      final newsResponse = await _newsService.fetchNews(apiUrl);
      if (!mounted) return;

      if (newsResponse.data.isEmpty) {
        setState(() {
          _currentState = NewsListStateValue.empty;
        });
      } else {
        setState(() {
          _articles = newsResponse.data;
          _currentState = NewsListStateValue.loaded;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
        _currentState = NewsListStateValue.error;
      });
    }
  }

  Widget _buildContent() {
    switch (_currentState) {
      case NewsListStateValue.loading:
        return const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        );
      case NewsListStateValue.error:
        return SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline_rounded,
                    color: Colors.redAccent,
                    size: 50,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Oops! Terjadi Kesalahan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh_rounded),
                    onPressed: () => _fetchNewsData(widget.apiUrl),
                    label: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          ),
        );
      case NewsListStateValue.empty:
        return SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_alt_rounded, size: 50, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('Tidak ada berita untuk kategori ini saat ini.'),
                ],
              ),
            ),
          ),
        );
      case NewsListStateValue.loaded:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => NewsListItem(article: _articles[index]),
            childCount: _articles.length,
          ),
        );
      case NewsListStateValue.initial:
        return SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.category_rounded, size: 50, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('Silakan pilih kategori berita di atas.'),
                ],
              ),
            ),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.apiUrl.isEmpty && _currentState == NewsListStateValue.initial) {
      return SliverFillRemaining(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.touch_app_rounded, size: 50, color: Colors.grey),
                const SizedBox(height: 16),
                Text('Pilih kategori untuk menampilkan berita.'),
              ],
            ),
          ),
        ),
      );
    }
    return _buildContent();
  }
}
