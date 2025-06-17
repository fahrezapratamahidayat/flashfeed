import 'package:flashfeed/src/data/models/article.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flashfeed/src/config/app_routes.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<NewsArticle> _savedArticles = [
    NewsArticle(
      title: 'Pecco Bagnaia Berhasil Pertahankan Gelar Juara Dunia MotoGP 2023',
      link: 'https://example.com/article1',
      isoDate: DateTime.now().subtract(const Duration(days: 2)),
      image:
          'https://images.unsplash.com/photo-1562402082-05a4e888ca96?q=80&w=1121&auto=format&fit=crop&ixlib=rb-4.1.0',
      description:
          'Pembalap Ducati, Francesco Bagnaia, berhasil mempertahankan gelar juara dunia MotoGP setelah finis di posisi kelima pada balapan pamungkas musim 2023 di Sirkuit Ricardo Tormo, Valencia.',
    ),
    NewsArticle(
      title:
          'Marc Marquez Resmi Bergabung dengan Ducati Gresini untuk Musim 2024',
      link: 'https://example.com/article2',
      isoDate: DateTime.now().subtract(const Duration(days: 3)),
      image:
          'https://images.unsplash.com/photo-1542281286-9e0a16bb7366?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0',
      description:
          'Setelah 11 tahun bersama Honda, Marc Marquez akhirnya memutuskan untuk bergabung dengan tim Gresini Racing yang menggunakan motor Ducati untuk musim MotoGP 2024.',
    ),
    NewsArticle(
      title:
          'Jadwal Lengkap MotoGP 2024: Indonesia Kembali Masuk Kalender Balapan',
      link: 'https://example.com/article3',
      isoDate: DateTime.now().subtract(const Duration(days: 5)),
      image:
          'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.1.0',
      description:
          'MotoGP telah mengumumkan kalender balapan untuk musim 2024. Indonesia kembali masuk dalam jadwal dengan balapan di Sirkuit Mandalika, Lombok.',
    ),
  ];

  void _removeFromSaved(int index) {
    setState(() {
      _savedArticles.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Artikel telah dihapus dari daftar simpanan'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Artikel Tersimpan',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_savedArticles.isNotEmpty)
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'clear') {
                  _showClearAllConfirmation();
                }
              },
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'clear',
                    child: Row(
                      children: [
                        Icon(Icons.delete_sweep, size: 20),
                        SizedBox(width: 8),
                        Text('Hapus Semua'),
                      ],
                    ),
                  ),
                ];
              },
            ),
        ],
      ),
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (_savedArticles.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.bookmark_border_rounded,
                size: 80,
                color: Colors.grey,
              ),
              Spacing.vertical(Spacing.md),
              const AppText(
                text: 'Belum ada artikel tersimpan',
                variant: AppTextVariant.titleMedium,
                textAlign: TextAlign.center,
              ),
              Spacing.vertical(Spacing.sm),
              const AppText(
                text: 'Artikel yang kamu simpan akan muncul di sini',
                textAlign: TextAlign.center,
                muted: true,
              ),
              Spacing.vertical(Spacing.lg),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.home);
                },
                icon: const Icon(Icons.explore),
                label: const Text('Jelajahi Berita'),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _savedArticles.length,
      itemBuilder: (context, index) {
        return _buildSavedArticleItem(index);
      },
    );
  }

  Widget _buildSavedArticleItem(int index) {
    final article = _savedArticles[index];

    return Dismissible(
      key: Key(article.link),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        _removeFromSaved(index);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        elevation: 1,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.articleDetail,
              arguments: article.title,
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        article.image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[200],
                            child: const Icon(
                              Icons.broken_image_outlined,
                              color: Colors.grey,
                            ),
                          );
                        },
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
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Spacing.vertical(Spacing.sm),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_today_outlined,
                                size: 14,
                                color: Colors.grey,
                              ),
                              Spacing.horizontal(4),
                              AppText(
                                text: DateFormat(
                                  'dd MMM yyyy',
                                  'id_ID',
                                ).format(article.isoDate),
                                variant: AppTextVariant.labelSmall,
                                muted: true,
                              ),
                              Spacing.horizontal(Spacing.sm),
                              const Icon(
                                Icons.bookmark,
                                size: 14,
                                color: Colors.blue,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacing.vertical(Spacing.sm),
                AppText(
                  text: article.description,
                  variant: AppTextVariant.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  muted: true,
                ),
                Spacing.vertical(Spacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        _removeFromSaved(index);
                      },
                      icon: const Icon(Icons.bookmark_remove, size: 18),
                      label: const Text('Hapus dari Simpanan'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red,
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                    Spacing.horizontal(Spacing.sm),
                    TextButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Berbagi artikel...'),
                            behavior: SnackBarBehavior.floating,
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.share, size: 18),
                      label: const Text('Bagikan'),
                      style: TextButton.styleFrom(
                        visualDensity: VisualDensity.compact,
                      ),
                    ),
                  ],
                ),
              ],
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
        title: const Text('Hapus Semua Artikel'),
        content: const Text(
          'Apakah Anda yakin ingin menghapus semua artikel tersimpan?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _savedArticles.clear();
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Semua artikel tersimpan telah dihapus'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
