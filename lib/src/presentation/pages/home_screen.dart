import 'package:flashfeed/src/presentation/pages/explore_screen.dart';
import 'package:flashfeed/src/presentation/pages/home_tab_content.dart';
import 'package:flashfeed/src/presentation/pages/profile_screen.dart';
import 'package:flashfeed/src/presentation/pages/saved_screen.dart';
import 'package:flashfeed/src/presentation/pages/trending_screen.dart';
import 'package:flashfeed/src/presentation/widgets/app_logo.dart';
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
    const HomeTabContent(),
    const ExploreScreen(),
    const TrendingScreen(),
    const SavedScreen(),
    const ProfileScreen(),
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
              backgroundColor: theme.scaffoldBackgroundColor,
              elevation: 0,
              scrolledUnderElevation: 0,
              systemOverlayStyle: isDarkMode
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
              toolbarHeight: 64,
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const AppIcon(width: 36, height: 36),
                        const SizedBox(width: 12),
                        Text(
                          'Flashfeed',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const ThemeSwitcher(),
                        const SizedBox(width: 8),
                        Container(
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? colorScheme.surfaceContainerHighest
                                      .withValues(alpha: 0.3)
                                : colorScheme.surfaceContainerHighest
                                      .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.notifications_none_rounded,
                              size: 24,
                              color: colorScheme.onSurfaceVariant,
                            ),
                            tooltip: 'Notifikasi',
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
