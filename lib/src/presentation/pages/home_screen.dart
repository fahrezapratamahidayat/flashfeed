import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/news_category_slider.dart';
import 'package:flashfeed/src/presentation/widgets/news_list_view.dart';
import 'package:flashfeed/src/presentation/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _selectedApiUrl = '';
  String _selectedCategoryLabel = 'FlashFeed';

  final List<Map<String, String>> avatarData = [
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/women/1.jpg',
      'name': 'Sarah W.',
    },
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/men/2.jpg',
      'name': 'Mike L.',
    },
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/women/3.jpg',
      'name': 'Lisa K.',
    },
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/men/4.jpg',
      'name': 'Chris P.',
    },
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/women/5.jpg',
      'name': 'Anna B.',
    },
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/men/6.jpg',
      'name': 'David M.',
    },
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/women/7.jpg',
      'name': 'Emily R.',
    },
    {
      'type': 'url',
      'value': 'https://randomuser.me/api/portraits/men/8.jpg',
      'name': 'James S.',
    },
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
    if (newsCategories.isNotEmpty) {
      _selectedCategoryLabel = newsCategories.first['label']!;
    }
  }

  void _onItemTapped(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onCategoryChanged(String categoryLabel, String apiUrl) {
    setState(() {
      _selectedApiUrl = apiUrl;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor:
            theme.appBarTheme.backgroundColor ?? theme.scaffoldBackgroundColor,
        elevation: theme.appBarTheme.elevation ?? 0,
        scrolledUnderElevation: 0,
        systemOverlayStyle: isDarkMode
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        toolbarHeight: 64,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          theme.primaryColor,
                          theme.primaryColor.withValues(alpha: 0.7),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.flash_on,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppText(
                    text: _selectedCategoryLabel,
                    variant: AppTextVariant.h4,
                  ),
                ],
              ),
              Row(
                children: [
                  ThemeSwitcher(),
                  Container(
                    decoration: BoxDecoration(
                      color: theme.cardColor.withValues(
                        alpha: isDarkMode ? 0.1 : 0.05,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.menu_rounded,
                        size: 22,
                        color: theme.iconTheme.color ?? colorScheme.onSurface,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  NewsCategorySlider(
                    initialSelectedValue: newsCategories.isNotEmpty
                        ? newsCategories.first['value']
                        : null,
                    onCategorySelected: _onCategoryChanged,
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height -
                        200, // Sesuaikan tinggi sesuai kebutuhan
                    child: NewsListView(apiUrl: _selectedApiUrl),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(),
        child: SafeArea(
          child: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: BottomNavigationBar(
              items: [
                _buildNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                ),
                _buildNavItem(
                  icon: Icons.explore_outlined,
                  activeIcon: Icons.explore_rounded,
                  label: 'Explore',
                ),
                _buildNavItem(
                  icon: Icons.trending_up_outlined,
                  activeIcon: Icons.trending_up_rounded,
                  label: 'Trending',
                ),
                _buildNavItem(
                  icon: Icons.bookmark_border_rounded,
                  activeIcon: Icons.bookmark_rounded,
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: _buildProfileIcon(isActive: false),
                  activeIcon: _buildProfileIcon(isActive: true),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor:
                  theme.bottomNavigationBarTheme.selectedItemColor ??
                  theme.primaryColor,
              unselectedItemColor:
                  theme.bottomNavigationBarTheme.unselectedItemColor ??
                  colorScheme.onSurface.withValues(alpha: 0.6),
              selectedFontSize: 11,
              unselectedFontSize: 11,
              selectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
              onTap: _onItemTapped,
            ),
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 22),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(activeIcon, size: 22),
      ),
      label: label,
    );
  }

  Widget _buildProfileIcon({required bool isActive}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isActive
            ? theme.primaryColor.withValues(alpha: 0.1)
            : theme.cardColor.withValues(alpha: isDarkMode ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(16),
        border: isActive
            ? Border.all(
                color: theme.primaryColor.withValues(alpha: 0.3),
                width: 1.5,
              )
            : null,
      ),
      child: Icon(
        isActive ? Icons.person_rounded : Icons.person_outline_rounded,
        size: 18,
        color: isActive
            ? theme.primaryColor
            : theme.iconTheme.color?.withValues(alpha: 0.6) ??
                  colorScheme.onSurface.withValues(alpha: 0.6),
      ),
    );
  }
}
