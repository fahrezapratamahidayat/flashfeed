import 'package:flashfeed/src/presentation/pages/explore_screen.dart';
import 'package:flashfeed/src/presentation/pages/home_tab_content.dart';
import 'package:flashfeed/src/presentation/pages/profile_screen.dart';
import 'package:flashfeed/src/presentation/pages/saved_screen.dart';
import 'package:flashfeed/src/presentation/pages/trending_screen.dart';
import 'package:flashfeed/src/presentation/widgets/app_text.dart';
import 'package:flashfeed/src/presentation/widgets/custom_bottom_navigation.dart';
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

  final List<Widget> _screens = [
    HomeTabContent(),
    ExploreScreen(),
    TrendingScreen(),
    SavedScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    HapticFeedback.lightImpact();
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: _selectedIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor:
                  theme.appBarTheme.backgroundColor ??
                  theme.scaffoldBackgroundColor,
              elevation: theme.appBarTheme.elevation ?? 0,
              scrolledUnderElevation: 0,
              systemOverlayStyle: isDarkMode
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
              toolbarHeight: 64,
              title: Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
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
                        AppText(text: 'Flashfeed', variant: AppTextVariant.h4),
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
                              color:
                                  theme.iconTheme.color ??
                                  colorScheme.onSurface,
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
            )
          : null,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
