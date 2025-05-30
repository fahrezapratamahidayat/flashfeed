import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: const BoxDecoration(),
      child: SafeArea(
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: BottomNavigationBar(
            items: [
              _buildNavItem(
                context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Home',
              ),
              _buildNavItem(
                context,
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore_rounded,
                label: 'Explore',
              ),
              _buildNavItem(
                context,
                icon: Icons.trending_up_outlined,
                activeIcon: Icons.trending_up_rounded,
                label: 'Trending',
              ),
              _buildNavItem(
                context,
                icon: Icons.bookmark_border_rounded,
                activeIcon: Icons.bookmark_rounded,
                label: 'Saved',
              ),
              BottomNavigationBarItem(
                icon: _buildProfileIcon(context, isActive: false),
                activeIcon: _buildProfileIcon(context, isActive: true),
                label: 'Profile',
              ),
            ],
            currentIndex: selectedIndex,
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
            onTap: onItemTapped,
          ),
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final theme = Theme.of(context);

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 22),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: theme.primaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(activeIcon, size: 22),
      ),
      label: label,
    );
  }

  Widget _buildProfileIcon(BuildContext context, {required bool isActive}) {
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
