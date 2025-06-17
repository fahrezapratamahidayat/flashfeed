import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/core/services/news_service.dart';
import 'package:flashfeed/src/data/models/article.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TrendingScreen extends StatefulWidget {
  const TrendingScreen({super.key});

  @override
  State<TrendingScreen> createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final NewsService _newsService = NewsService();
  bool _isLoading = true;
  List<NewsArticle> _trendingArticles = [];
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchTrendingNews();
  }

  Future<void> _fetchTrendingNews() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final response = await _newsService.fetchNews(
        'https://berita-indo-api-next.vercel.app/api/antara-news/top-news',
      );

      if (!mounted) return;

      setState(() {
        _trendingArticles = response.data;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString().replaceFirst("Exception: ", "");
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(
          'Trending',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            tooltip: 'Cari berita trending',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchTrendingNews,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.grey),
              Spacing.vertical(Spacing.md),
              AppText(
                text: 'Gagal memuat berita trending',
                variant: AppTextVariant.titleMedium,
              ),
              Spacing.vertical(Spacing.sm),
              AppText(
                text: _errorMessage,
                textAlign: TextAlign.center,
                muted: true,
              ),
              Spacing.vertical(Spacing.md),
              ElevatedButton(
                onPressed: _fetchTrendingNews,
                child: const Text('Coba Lagi'),
              ),
            ],
          ),
        ),
      );
    }

    if (_trendingArticles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.trending_up, size: 60, color: Colors.grey),
              Spacing.vertical(Spacing.md),
              const AppText(
                text: 'Belum ada berita trending saat ini',
                variant: AppTextVariant.titleMedium,
              ),
              Spacing.vertical(Spacing.md),
              ElevatedButton(
                onPressed: _fetchTrendingNews,
                child: const Text('Muat Ulang'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        _buildTrendingHeader(),
        _buildTopTrendingArticle(),
        _buildTrendingList(),
      ],
    );
  }

  Widget _buildTrendingHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: Row(
        children: [
          const Icon(Icons.trending_up, color: Colors.red, size: 28),
          Spacing.horizontal(Spacing.sm),
          const AppText(
            text: 'Berita Populer Hari Ini',
            variant: AppTextVariant.titleLarge,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget _buildTopTrendingArticle() {
    if (_trendingArticles.isEmpty) return const SizedBox();

    final topArticle = _trendingArticles[0];

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.articleDetail,
              arguments: topArticle.title,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      topArticle.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: const Center(
                            child: Icon(
                              Icons.broken_image_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.trending_up,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'TOP',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).cardColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: topArticle.title,
                      variant: AppTextVariant.titleLarge,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacing.vertical(Spacing.sm),
                    AppText(
                      text: topArticle.description,
                      variant: AppTextVariant.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      muted: true,
                    ),
                    Spacing.vertical(Spacing.md),
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                            'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
                          ),
                        ),
                        Spacing.horizontal(Spacing.sm),
                        const AppText(
                          text: 'Antara News',
                          variant: AppTextVariant.labelMedium,
                        ),
                        Spacing.horizontal(Spacing.sm),
                        Container(
                          width: 4,
                          height: 4,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Spacing.horizontal(Spacing.sm),
                        AppText(
                          text: DateFormat(
                            'dd MMM yyyy',
                            'id_ID',
                          ).format(topArticle.isoDate),
                          variant: AppTextVariant.labelMedium,
                          muted: true,
                        ),
                        const Spacer(),
                        const Icon(Icons.bookmark_border, size: 20),
                        Spacing.horizontal(Spacing.sm),
                        const Icon(Icons.share, size: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingList() {
    if (_trendingArticles.length <= 1) return const SizedBox();
    final otherArticles = _trendingArticles.sublist(1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: AppText(
            text: 'Berita Trending Lainnya',
            variant: AppTextVariant.titleMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: otherArticles.length,
          itemBuilder: (context, index) {
            final article = otherArticles[index];
            return _buildTrendingListItem(
              article,
              index + 2,
            ); // +2 karena index 1 adalah artikel top
          },
        ),
      ],
    );
  }

  Widget _buildTrendingListItem(NewsArticle article, int rank) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.articleDetail,
          arguments: article.title,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: rank <= 3 ? Colors.red : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(6),
              ),
              child: AppText(
                text: rank.toString(),
                color: rank <= 3 ? Colors.white : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacing.horizontal(Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: article.title,
                    variant: AppTextVariant.titleMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacing.vertical(Spacing.sm),
                  Row(
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 14,
                        color: Colors.grey,
                      ),
                      Spacing.horizontal(4),
                      AppText(
                        text: DateFormat(
                          'dd MMM',
                          'id_ID',
                        ).format(article.isoDate),
                        variant: AppTextVariant.labelSmall,
                        muted: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacing.horizontal(Spacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  article.image,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
