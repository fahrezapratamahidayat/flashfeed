import 'package:flashfeed/src/data/models/article.dart';
import 'package:flashfeed/src/presentation/widgets/news_category_slider.dart';
import 'package:flashfeed/src/presentation/widgets/news_list_view.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  String _selectedApiUrl = '';
  String _selectedCategoryLabel = '';
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Data untuk featured slider
  final List<NewsArticle> _featuredArticles = [
    NewsArticle(
      title: 'Teknologi AI Terbaru Mampu Prediksi Cuaca dengan Akurasi Tinggi',
      link: 'https://example.com/article1',
      isoDate: DateTime.now().subtract(const Duration(days: 1)),
      image:
          'https://images.unsplash.com/photo-1620712943543-bcc4688e7485?q=80&w=1965&auto=format&fit=crop',
      description:
          'Teknologi kecerdasan buatan terbaru telah berhasil memprediksi cuaca dengan tingkat akurasi yang belum pernah dicapai sebelumnya.',
    ),
    NewsArticle(
      title:
          'Peluncuran Smartphone Terbaru dengan Teknologi Kamera Revolusioner',
      link: 'https://example.com/article2',
      isoDate: DateTime.now().subtract(const Duration(days: 2)),
      image:
          'https://images.unsplash.com/photo-1511707171634-5f897ff02aa9?q=80&w=2080&auto=format&fit=crop',
      description:
          'Produsen smartphone ternama meluncurkan perangkat terbaru dengan teknologi kamera yang mengubah standar fotografi mobile.',
    ),
    NewsArticle(
      title: 'Penemuan Vaksin Baru Berpotensi Mengatasi Varian Virus Terbaru',
      link: 'https://example.com/article3',
      isoDate: DateTime.now().subtract(const Duration(days: 3)),
      image:
          'https://images.unsplash.com/photo-1584036561566-baf8f5f1b144?q=80&w=2032&auto=format&fit=crop',
      description:
          'Tim peneliti internasional mengumumkan penemuan vaksin baru yang efektif melawan varian virus yang baru muncul.',
    ),
  ];

  final List<Map<String, String>> newsCategories = [
    {
      'label': 'Terkini',
      'value': 'terkini',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/terkini',
    },
    {
      'label': 'Top News',
      'value': 'top-news',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/top-news',
    },
    {
      'label': 'Politik',
      'value': 'politik',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/politik',
    },
    {
      'label': 'Hukum',
      'value': 'hukum',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/hukum',
    },
    {
      'label': 'Ekonomi',
      'value': 'ekonomi',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/ekonomi',
    },
    {
      'label': 'Metro',
      'value': 'metro',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/metro',
    },
    {
      'label': 'Sepak Bola',
      'value': 'sepakbola',
      'url':
          'https://berita-indo-api-next.vercel.app/api/antara-news/sepakbola',
    },
    {
      'label': 'Olahraga',
      'value': 'olahraga',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/olahraga',
    },
    {
      'label': 'Hiburan',
      'value': 'hiburan',
      'url': 'https://berita-indo-api-next.vercel.app/api/antara-news/hiburan',
    },
    {
      'label': 'Teknologi',
      'value': 'teknologi',
      'url':
          'https://berita-indo-api-next.vercel.app/api/antara-news/teknologi',
    },
    {
      'label': 'Gaya Hidup',
      'value': 'lifestyle',
      'url':
          'https://berita-indo-api-next.vercel.app/api/antara-news/lifestyle',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _startAutoSlide();
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        int nextPage = (_currentPage + 1) % _featuredArticles.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoSlide();
      }
    });
  }

  void _onCategoryChanged(String categoryLabel, String apiUrl) {
    setState(() {
      _selectedApiUrl = apiUrl;
      _selectedCategoryLabel = categoryLabel;
    });
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Column(
        children: [
          NewsCategorySlider(
            initialSelectedValue: 'terkini',
            onCategorySelected: _onCategoryChanged,
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 450,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _featuredArticles.length,
                      onPageChanged: _onPageChanged,
                      itemBuilder: (context, index) {
                        final article = _featuredArticles[index];
                        return _buildFeaturedCard(article, context);
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
                if (_selectedApiUrl.isNotEmpty)
                  NewsListView(apiUrl: _selectedApiUrl)
                else
                  SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.category_rounded,
                            size: 48,
                            color: colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.3,
                            ),
                          ),
                          const SizedBox(height: 16),
                          AppText(
                            text: 'Pilih kategori untuk melihat berita',
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(NewsArticle article, BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
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
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                article.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.broken_image_outlined,
                    size: 48,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                  stops: const [0.5, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Artikel disimpan'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                padding: const EdgeInsets.all(8),
                iconSize: 20,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: article.title,
                    variant: AppTextVariant.titleMedium,
                    color: Colors.white,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundImage: const NetworkImage(
                              'https://randomuser.me/api/portraits/men/32.jpg',
                            ),
                          ),
                          const SizedBox(width: 8),
                          AppText(
                            text: 'USA Today',
                            variant: AppTextVariant.small,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ],
                      ),
                      AppText(
                        text: DateFormat('dd MMM yyyy').format(article.isoDate),
                        variant: AppTextVariant.small,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: 'John Smith',
                        variant: AppTextVariant.small,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 4,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.7),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 12),
                          AppText(
                            text: '5 menit baca',
                            variant: AppTextVariant.small,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ],
                      ),
                      AppText(
                        text: '5k Likes',
                        variant: AppTextVariant.small,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
