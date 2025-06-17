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
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? colorScheme.surface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? colorScheme.surfaceVariant.withOpacity(0.1)
                : colorScheme.outline.withOpacity(0.08),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: BottomNavigationBar(
            items: [
              _buildNavItem(
                context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home_rounded,
                label: 'Beranda',
              ),
              _buildNavItem(
                context,
                icon: Icons.explore_outlined,
                activeIcon: Icons.explore_rounded,
                label: 'Jelajahi',
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
                label: 'Tersimpan',
              ),
              BottomNavigationBarItem(
                icon: _buildProfileIcon(context, isActive: false),
                activeIcon: _buildProfileIcon(context, isActive: true),
                label: 'Profil',
              ),
            ],
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: colorScheme.primary,
            unselectedItemColor: colorScheme.onSurfaceVariant.withOpacity(0.7),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              height: 1.5,
              letterSpacing: 0.2,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
            showUnselectedLabels: true,
            enableFeedback: true,
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
    final colorScheme = theme.colorScheme;

    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.all(6),
        child: Icon(
          icon,
          size: 24,
          color: colorScheme.onSurfaceVariant.withOpacity(0.7),
        ),
      ),
      activeIcon: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: colorScheme.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(activeIcon, size: 24, color: colorScheme.primary),
      ),
      label: label,
      tooltip: label,
    );
  }

  Widget _buildProfileIcon(BuildContext context, {required bool isActive}) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isActive
            ? colorScheme.primary.withOpacity(0.12)
            : isDarkMode
            ? colorScheme.surfaceVariant.withOpacity(0.3)
            : colorScheme.surfaceVariant.withOpacity(0.2),
        borderRadius: BorderRadius.circular(18),
        border: isActive
            ? Border.all(
                color: colorScheme.primary.withOpacity(0.3),
                width: 1.5,
              )
            : null,
      ),
      child: Icon(
        isActive ? Icons.person_rounded : Icons.person_outline_rounded,
        size: 20,
        color: isActive
            ? colorScheme.primary
            : colorScheme.onSurfaceVariant.withOpacity(0.7),
      ),
    );
  }
}
