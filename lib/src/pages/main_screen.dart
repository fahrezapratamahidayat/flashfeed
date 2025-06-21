import 'package:flashfeed/src/config/app_routes.dart';
import 'package:flashfeed/src/pages/explore_screen.dart';
import 'package:flashfeed/src/pages/home_screen.dart';
import 'package:flashfeed/src/pages/profile_screen.dart';
import 'package:flashfeed/src/pages/saved_screen.dart';
import 'package:flashfeed/src/pages/trending_screen.dart';
import 'package:flashfeed/src/providers/auth_provider.dart';
import 'package:flashfeed/src/widgets/app_logo.dart';
import 'package:flashfeed/src/widgets/custom_bottom_navigation.dart';
import 'package:flashfeed/src/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
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

    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

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
                          'FlashFeed',
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
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                          ),
                          child: Material(
                            type: MaterialType.transparency,
                            child: InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                Navigator.pushNamed(context, AppRoutes.profile);
                              },
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage:
                                    user?.avatar != null &&
                                        user!.avatar.isNotEmpty
                                    ? NetworkImage(user.avatar)
                                    : const NetworkImage(
                                        'https://randomuser.me/api/portraits/men/42.jpg',
                                      ),
                              ),
                            ),
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
