import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/core/services/news_service.dart';
import 'package:flashfeed/src/models/news_response.dart';
import 'package:flashfeed/src/widgets/app_text.dart';
import 'package:flashfeed/src/widgets/cached_network_image.dart';
import 'package:flashfeed/src/widgets/spacing.dart';
import 'package:flashfeed/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final NewsService _newsService = NewsService();
  List<NewsArticle> _savedArticles = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchSavedArticles();
  }

  Future<void> _fetchSavedArticles() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (!authProvider.isAuthenticated) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Anda harus login untuk melihat artikel tersimpan';
        });
        return;
      }

      final response = await _newsService.fetchBookmarkedArticles();

      if (mounted) {
        setState(() {
          _savedArticles = response;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString().replaceFirst("Exception: ", "");
        });
      }
    }
  }

  Future<void> _removeFromSaved(int index) async {
    final articleId = _savedArticles[index].id;

    try {
      final success = await _newsService.removeBookmark(articleId);

      if (success && mounted) {
        setState(() {
          _savedArticles.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Artikel dihapus dari simpanan'),
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

  Future<void> _clearAllSaved() async {
    setState(() {
      _isLoading = true;
    });

    try {
      bool allSuccess = true;

      for (final article in List.from(_savedArticles)) {
        try {
          final success = await _newsService.removeBookmark(article.id);
          if (!success) {
            allSuccess = false;
          }
        } catch (e) {
          allSuccess = false;
        }
      }

      if (mounted) {
        setState(() {
          if (allSuccess) {
            _savedArticles.clear();
          }
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              allSuccess
                  ? 'Semua artikel dihapus'
                  : 'Beberapa artikel gagal dihapus',
            ),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: allSuccess ? null : Colors.orange.shade400,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceFirst("Exception: ", "")),
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: Colors.red.shade400,
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
          'Tersimpan',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
        ),
        actions: [
          if (_savedArticles.isNotEmpty)
            IconButton(
              onPressed: _fetchSavedArticles,
              icon: const Icon(Icons.refresh_rounded, size: 22),
              tooltip: 'Muat ulang',
            ),
          if (_savedArticles.isNotEmpty)
            IconButton(
              onPressed: _showClearAllConfirmation,
              icon: const Icon(Icons.delete_sweep_rounded, size: 22),
              tooltip: 'Hapus semua',
            ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchSavedArticles,
        strokeWidth: 2.5,
        child: _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator(strokeWidth: 2.5));
    }

    if (_errorMessage.isNotEmpty) {
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
                onPressed: _fetchSavedArticles,
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

    if (_savedArticles.isEmpty) {
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
                  Icons.bookmark_border_rounded,
                  size: 64,
                  color: Colors.grey.shade400,
                ),
              ),
              Spacing.vertical(24),
              AppText(
                text: 'Belum ada artikel tersimpan',
                variant: AppTextVariant.titleLarge,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
              Spacing.vertical(8),
              AppText(
                text: 'Simpan artikel favoritmu dan baca nanti',
                textAlign: TextAlign.center,
                color: Colors.grey.shade600,
              ),
              Spacing.vertical(24),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                icon: const Icon(
                  Icons.explore_rounded,
                  size: 20,
                  color: Colors.white,
                ),
                label: const Text(
                  'Jelajahi Berita',
                  style: TextStyle(color: Colors.white),
                ),
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
      itemCount: _savedArticles.length,
      itemBuilder: (context, index) {
        return _buildSavedArticleItem(index);
      },
    );
  }

  Widget _buildSavedArticleItem(int index) {
    final article = _savedArticles[index];
    final theme = Theme.of(context);
    const double imageWidth = 100.0;
    const double imageHeight = 100.0;

    return Dismissible(
      key: Key(article.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 24),
      ),
      onDismissed: (direction) {
        _removeFromSaved(index);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
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
            borderRadius: BorderRadius.circular(16.0),
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(
                  color: Colors.grey.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: imageWidth,
                        height: imageHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.grey[100],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: CachedNetworkImageWrapper(
                            imageUrl: article.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Icon(
                                Icons.image_outlined,
                                size: 32,
                                color: Colors.grey[400],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Spacing.horizontal(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(6.0),
                              ),
                              child: AppText(
                                text: article.category.toUpperCase(),
                                variant: AppTextVariant.small,
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacing.vertical(8),
                            AppText(
                              text: article.title,
                              variant: AppTextVariant.titleMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                            ),
                            Spacing.vertical(12),
                            Row(
                              children: [
                                Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipOval(
                                    child: CachedNetworkImageWrapper(
                                      imageUrl: article.author.avatar,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Container(
                                            color: Colors.grey[200],
                                            child: Icon(
                                              Icons.person,
                                              size: 14,
                                              color: Colors.grey[500],
                                            ),
                                          ),
                                    ),
                                  ),
                                ),
                                Spacing.horizontal(8),
                                Flexible(
                                  child: AppText(
                                    text: article.author.name,
                                    variant: AppTextVariant.small,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  width: 3,
                                  height: 3,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                AppText(
                                  text: DateFormat(
                                    'dd MMM yyyy',
                                    'id_ID',
                                  ).format(article.createdAt),
                                  variant: AppTextVariant.small,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacing.vertical(16),
                  Row(
                    children: [
                      Icon(
                        Icons.bookmark_rounded,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      Spacing.horizontal(4),
                      AppText(
                        text: 'Tersimpan',
                        variant: AppTextVariant.small,
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => _removeFromSaved(index),
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
            ),
          ),
        ),
      ),
    );
  }

  void _showClearAllConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Hapus Semua Artikel',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        content: const Text(
          'Semua artikel tersimpan akan dihapus. Tindakan ini tidak dapat dibatalkan.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _clearAllSaved();
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
