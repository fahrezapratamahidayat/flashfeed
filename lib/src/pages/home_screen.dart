import 'package:flashfeed/src/core/services/news_service.dart';
import 'package:flashfeed/src/models/news_response.dart';
import 'package:flashfeed/src/data/news_data.dart';
import 'package:flashfeed/src/widgets/news_category_slider.dart';
import 'package:flashfeed/src/widgets/app_text.dart';
import 'package:flashfeed/src/widgets/news_list_item.dart';
import 'package:flashfeed/src/widgets/shimmer_effects.dart';
import 'package:flashfeed/src/widgets/trending_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsService _newsService = NewsService();
  late Future<NewsResponse> _trendingNews;
  String _selectedApiUrl = '';
  String _selectedCategoryLabel = '';
  final PageController _pageController = PageController();
  int _currentPage = 0;

  bool _isNewsLoading = false;
  bool _isLoadingMore = false;
  List<NewsArticle> _articles = [];
  String _errorMessage = '';
  bool _hasError = false;
  bool _isEmpty = false;
  bool _hasMoreArticles = true;
  final int _articlesPerPage = 5;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _trendingNews = _newsService.fetchNews(
      'https://rest-api-berita.vercel.app/api/v1/news?isTrending=true&limit=5',
    );
    _scrollController.addListener(_scrollListener);

    Future.delayed(Duration.zero, () {
      _startAutoSlide();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoadingMore &&
        !_isNewsLoading &&
        _hasMoreArticles) {
      _loadMoreArticles();
    }
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _trendingNews.then((newsResponse) {
          if (newsResponse.data.articles.isNotEmpty) {
            int nextPage =
                (_currentPage + 1) % newsResponse.data.articles.length;
            _pageController.animateToPage(
              nextPage,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
            _startAutoSlide();
          }
        });
      }
    });
  }

  void _onCategoryChanged(String categoryLabel, String apiUrl) {
    setState(() {
      _selectedApiUrl = apiUrl;
      _selectedCategoryLabel = categoryLabel;
      _articles = [];
      _currentPage = 1;
      _hasMoreArticles = true;
    });

    if (apiUrl.isNotEmpty) {
      _fetchNewsData(apiUrl);
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  Future<void> _fetchNewsData(String apiUrl) async {
    final String paginatedUrl = _addPaginationToUrl(
      apiUrl,
      _currentPage,
      _articlesPerPage,
    );

    setState(() {
      _isNewsLoading = true;
      _errorMessage = '';
      _hasError = false;
      _isEmpty = false;
    });

    try {
      final newsResponse = await _newsService.fetchNews(paginatedUrl);
      if (!mounted) return;

      if (newsResponse.data.articles.isEmpty) {
        setState(() {
          _isEmpty = true;
          _isNewsLoading = false;
          _hasMoreArticles = false;
        });
      } else {
        setState(() {
          _articles = newsResponse.data.articles;
          _isNewsLoading = false;
          _hasMoreArticles = newsResponse.data.pagination.hasMore;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
        _hasError = true;
        _isNewsLoading = false;
      });
    }
  }

  Future<void> _loadMoreArticles() async {
    if (!_hasMoreArticles || _isLoadingMore) return;

    setState(() {
      _isLoadingMore = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final String paginatedUrl = _addPaginationToUrl(
        _selectedApiUrl,
        nextPage,
        _articlesPerPage,
      );

      final newsResponse = await _newsService.fetchNews(paginatedUrl);
      if (!mounted) return;

      if (newsResponse.data.articles.isNotEmpty) {
        setState(() {
          _articles.addAll(newsResponse.data.articles);
          _currentPage = nextPage;
          _hasMoreArticles = newsResponse.data.pagination.hasMore;
        });
      } else {
        setState(() {
          _hasMoreArticles = false;
        });
      }
    } catch (e) {
      debugPrint('Error loading more articles: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  String _addPaginationToUrl(String url, int page, int limit) {
    final Uri uri = Uri.parse(url);
    final Map<String, dynamic> queryParams = Map<String, dynamic>.from(
      uri.queryParameters,
    );

    queryParams['page'] = page.toString();
    queryParams['limit'] = limit.toString();

    final newUri = uri.replace(queryParameters: queryParams);
    return newUri.toString();
  }

  Widget _buildNewsList() {
    if (_isNewsLoading) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: ShimmerNewsList(itemCount: 3),
        ),
      );
    }

    if (_hasError) {
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
                  onPressed: () => _fetchNewsData(_selectedApiUrl),
                  label: const Text('Coba Lagi'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_isEmpty) {
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
    }

    if (_articles.isEmpty && _selectedApiUrl.isEmpty) {
      return SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.category_rounded,
                size: 48,
                color: Theme.of(
                  context,
                ).colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
              ),
              const SizedBox(height: 16),
              AppText(
                text: 'Pilih kategori untuk melihat berita',
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < _articles.length) {
            return NewsListItem(article: _articles[index]);
          } else if (_hasMoreArticles) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
            );
          } else if (_articles.isNotEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: Text(
                  'Tidak ada artikel lagi',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ),
            );
          }
          return null;
        },
        childCount: _articles.isEmpty
            ? 0
            : _hasMoreArticles
            ? _articles.length + 1
            : _articles.length + 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Column(
        children: [
          NewsCategorySlider(
            initialSelectedValue: newsCategories.isNotEmpty
                ? newsCategories.first['value']
                : '',
            onCategorySelected: _onCategoryChanged,
          ),
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 400,
                    child: FutureBuilder<NewsResponse>(
                      future: _trendingNews,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const ShimmerTrendingCard();
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('Error loading trending news'),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.data.articles.isEmpty) {
                          return const Center(child: Text('No trending news'));
                        }

                        final articles = snapshot.data!.data.articles;
                        return PageView.builder(
                          controller: _pageController,
                          itemCount: articles.length,
                          onPageChanged: _onPageChanged,
                          itemBuilder: (context, index) {
                            return TrendingCard(article: articles[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (_selectedCategoryLabel.isNotEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: _selectedCategoryLabel,
                            variant: AppTextVariant.titleMedium,
                            fontWeight: FontWeight.w700,
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_forward_rounded,
                              size: 16,
                              color: colorScheme.primary,
                            ),
                            label: AppText(
                              text: 'Lihat Semua',
                              variant: AppTextVariant.labelMedium,
                              color: colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                _buildNewsList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
