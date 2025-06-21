import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/core/services/news_service.dart';
import 'package:flashfeed/src/models/news_response.dart';
import 'package:flashfeed/src/widgets/app_text.dart';
import 'package:flashfeed/src/widgets/spacing.dart';
import 'package:flashfeed/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyNewsScreen extends StatefulWidget {
  const MyNewsScreen({super.key});

  @override
  State<MyNewsScreen> createState() => _MyNewsScreenState();
}

class _MyNewsScreenState extends State<MyNewsScreen> {
  final NewsService _newsService = NewsService();
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';
  List<NewsArticle> _myArticles = [];

  @override
  void initState() {
    super.initState();
    _fetchMyArticles();
  }

  Future<void> _fetchMyArticles() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (!authProvider.isAuthenticated) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = 'Anda harus login untuk melihat artikel Anda';
        });
        return;
      }

      final response = await _newsService.fetchMyArticles();

      if (mounted) {
        setState(() {
          _myArticles = response.data.articles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
          _errorMessage = e.toString().replaceFirst("Exception: ", "");
        });
      }
    }
  }

  Future<void> _deleteArticle(String articleId) async {
    try {
      final success = await _newsService.deleteArticle(articleId);

      if (success && mounted) {
        setState(() {
          _myArticles.removeWhere((article) => article.id == articleId);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Artikel berhasil dihapus'),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst("Exception: ", "")),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.red.shade400,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text(
          'Artikel Saya',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _fetchMyArticles,
            icon: const Icon(Icons.refresh_rounded, size: 22),
            tooltip: 'Muat ulang',
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                AppRoutes.createArticle,
              ).then((_) => _fetchMyArticles());
            },
            icon: const Icon(Icons.add_rounded, size: 22),
            tooltip: 'Buat artikel',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchMyArticles,
        strokeWidth: 2.5,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2.5));
    }

    if (_hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.error_outline_rounded,
                  size: 48,
                  color: Colors.red.shade400,
                ),
              ),
              Spacing.vertical(24),
              AppText(
                text: 'Gagal memuat artikel',
                variant: AppTextVariant.titleLarge,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Spacing.vertical(8),
              AppText(
                text: _errorMessage,
                textAlign: TextAlign.center,
                color: Colors.grey.shade600,
              ),
              Spacing.vertical(24),
              FilledButton.icon(
                onPressed: _fetchMyArticles,
                icon: const Icon(Icons.refresh_rounded, size: 20),
                label: const Text('Coba Lagi'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_myArticles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.article_outlined,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
              ),
              Spacing.vertical(24),
              AppText(
                text: 'Belum ada artikel',
                variant: AppTextVariant.titleLarge,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Spacing.vertical(8),
              AppText(
                text: 'Mulai buat artikel pertamamu dan bagikan ke dunia',
                textAlign: TextAlign.center,
                color: Colors.grey.shade600,
              ),
              Spacing.vertical(24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.createArticle,
                  ).then((_) => _fetchMyArticles());
                },
                icon: const Icon(Icons.add_rounded, size: 20),
                label: const Text('Buat Artikel'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: _myArticles.length,
      itemBuilder: (context, index) {
        final article = _myArticles[index];
        return _buildArticleCard(article);
      },
    );
  }

  Widget _buildArticleCard(NewsArticle article) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.articleDetail,
              arguments: article.id,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.1),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          article.imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade100,
                              child: Icon(
                                Icons.image_outlined,
                                size: 48,
                                color: Colors.grey.shade400,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    if (article.isTrending)
                      Positioned(
                        top: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.trending_up_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Trending',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.9,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          article.category.toUpperCase(),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: article.title,
                        variant: AppTextVariant.titleLarge,
                        fontWeight: FontWeight.w700,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacing.vertical(12),
                      AppText(
                        text: article.content,
                        variant: AppTextVariant.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        color: Colors.grey.shade600,
                      ),
                      Spacing.vertical(16),
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.grey.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                article.author.avatar.isNotEmpty
                                    ? article.author.avatar
                                    : 'https://randomuser.me/api/portraits/men/42.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade200,
                                    child: Icon(
                                      Icons.person,
                                      size: 18,
                                      color: Colors.grey.shade500,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Spacing.horizontal(12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: article.author.name,
                                  variant: AppTextVariant.bodyMedium,
                                  fontWeight: FontWeight.w600,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Spacing.vertical(2),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.schedule_rounded,
                                      size: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                    Spacing.horizontal(4),
                                    AppText(
                                      text: article.publishedAt,
                                      variant: AppTextVariant.small,
                                      color: Colors.grey.shade600,
                                    ),
                                    if (article.readTime.isNotEmpty) ...[
                                      Spacing.horizontal(12),
                                      Icon(
                                        Icons.visibility_outlined,
                                        size: 14,
                                        color: Colors.grey.shade500,
                                      ),
                                      Spacing.horizontal(4),
                                      AppText(
                                        text: article.readTime,
                                        variant: AppTextVariant.small,
                                        color: Colors.grey.shade600,
                                      ),
                                    ],
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.updateArticle,
                                    arguments: article.id,
                                  ).then((_) => _fetchMyArticles());
                                },
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.edit_outlined,
                                    size: 20,
                                    color: theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              Spacing.horizontal(4),
                              InkWell(
                                onTap: () =>
                                    _showDeleteConfirmation(article.id),
                                borderRadius: BorderRadius.circular(8),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    size: 20,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (article.tags.isNotEmpty) ...[
                        Spacing.vertical(16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: article.tags.map((tag) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                tag,
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(String articleId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Hapus Artikel',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Artikel yang dihapus tidak dapat dikembalikan. Yakin ingin melanjutkan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteArticle(articleId);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
