import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/core/services/news_service.dart';
import 'package:flashfeed/src/models/news_response.dart';
import 'package:flashfeed/src/widgets/app_text.dart';
import 'package:flashfeed/src/widgets/spacing.dart';
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
        '${_newsService.baseApiUrl}/news/trending',
      );

      if (!mounted) return;

      setState(() {
        _trendingArticles = response.data.articles;
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
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: RefreshIndicator(
        onRefresh: _fetchTrendingNews,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              backgroundColor: colorScheme.surface,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
                title: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.error,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.local_fire_department,
                        color: colorScheme.onError,
                        size: 18,
                      ),
                    ),
                    Spacing.horizontal(Spacing.sm),
                    AppText(
                      text: 'Trending',
                      variant: AppTextVariant.titleLarge,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search, color: colorScheme.onSurface),
                  onPressed: () {},
                ),
                Spacing.horizontal(Spacing.sm),
              ],
            ),
            SliverToBoxAdapter(
              child: RefreshIndicator(
                onRefresh: _fetchTrendingNews,
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return _buildErrorState();
    }

    if (_trendingArticles.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        _buildFeaturedArticle(),
        Spacing.vertical(Spacing.xl),
        _buildTrendingList(),
      ],
    );
  }

  Widget _buildErrorState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.errorContainer.withValues(alpha: 0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.wifi_off, size: 48, color: colorScheme.error),
          ),
          Spacing.vertical(Spacing.lg),
          AppText(
            text: 'Gagal Memuat Trending',
            variant: AppTextVariant.titleMedium,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          Spacing.vertical(Spacing.sm),
          AppText(
            text: _errorMessage,
            variant: AppTextVariant.bodyMedium,
            color: colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
          Spacing.vertical(Spacing.lg),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: _fetchTrendingNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Coba Lagi'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.trending_up,
              size: 48,
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          Spacing.vertical(Spacing.lg),
          AppText(
            text: 'Belum Ada Trending',
            variant: AppTextVariant.titleMedium,
            fontWeight: FontWeight.w600,
            textAlign: TextAlign.center,
          ),
          Spacing.vertical(Spacing.sm),
          AppText(
            text: 'Tidak ada berita trending saat ini',
            variant: AppTextVariant.bodyMedium,
            color: colorScheme.onSurfaceVariant,
            textAlign: TextAlign.center,
          ),
          Spacing.vertical(Spacing.lg),
          SizedBox(
            width: 200,
            child: ElevatedButton(
              onPressed: _fetchTrendingNews,
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: colorScheme.onPrimary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Muat Ulang'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedArticle() {
    if (_trendingArticles.isEmpty) return const SizedBox();

    final topArticle = _trendingArticles[0];
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.1)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.articleDetail,
            arguments: topArticle.id,
          );
        },
        borderRadius: BorderRadius.circular(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.error,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.local_fire_department,
                          size: 14,
                          color: colorScheme.onError,
                        ),
                        Spacing.horizontal(4),
                        AppText(
                          text: 'HOT',
                          variant: AppTextVariant.labelSmall,
                          color: colorScheme.onError,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.bookmark_border,
                      size: 20,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    style: IconButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(24, 24),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: topArticle.title,
                    variant: AppTextVariant.titleLarge,
                    fontWeight: FontWeight.w600,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacing.vertical(Spacing.sm),
                  AppText(
                    text: topArticle.content,
                    variant: AppTextVariant.bodyMedium,
                    color: colorScheme.onSurfaceVariant,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Spacing.vertical(Spacing.lg),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: colorScheme.surfaceContainerHighest,
                      backgroundImage: NetworkImage(
                        topArticle.author.avatar.isNotEmpty
                            ? topArticle.author.avatar
                            : 'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg',
                      ),
                    ),
                  ),
                  Spacing.horizontal(Spacing.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          text: topArticle.author.name.isNotEmpty
                              ? topArticle.author.name
                              : 'Antara News',
                          variant: AppTextVariant.bodySmall,
                          fontWeight: FontWeight.w500,
                        ),
                        AppText(
                          text: DateFormat(
                            'dd MMM yyyy',
                            'id_ID',
                          ).format(topArticle.createdAt),
                          variant: AppTextVariant.labelSmall,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrendingList() {
    if (_trendingArticles.length <= 1) return const SizedBox();

    final otherArticles = _trendingArticles.sublist(1);
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: AppText(
            text: 'Trending Lainnya',
            variant: AppTextVariant.titleMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: otherArticles.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              color: colorScheme.outline.withValues(alpha: 0.1),
              indent: 16,
              endIndent: 16,
            ),
            itemBuilder: (context, index) {
              final article = otherArticles[index];
              return _buildTrendingListItem(article, index + 2);
            },
          ),
        ),
        Spacing.vertical(Spacing.xl),
      ],
    );
  }

  Widget _buildTrendingListItem(NewsArticle article, int rank) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTopThree = rank <= 3;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.articleDetail,
          arguments: article.id,
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isTopThree
                    ? colorScheme.error
                    : colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: AppText(
                text: rank.toString(),
                variant: AppTextVariant.labelMedium,
                color: isTopThree
                    ? colorScheme.onError
                    : colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacing.horizontal(Spacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: article.title,
                    variant: AppTextVariant.bodyMedium,
                    fontWeight: FontWeight.w500,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacing.vertical(6),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 12,
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.7,
                        ),
                      ),
                      Spacing.horizontal(4),
                      AppText(
                        text: DateFormat(
                          'dd MMM',
                          'id_ID',
                        ).format(article.createdAt),
                        variant: AppTextVariant.labelSmall,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Spacing.horizontal(Spacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                ),
                child: Image.network(
                  article.imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.primary,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported_outlined,
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.5,
                      ),
                      size: 20,
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
