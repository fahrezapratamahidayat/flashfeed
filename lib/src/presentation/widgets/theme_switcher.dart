import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flashfeed/src/config/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDarkMode = theme.brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor.withValues(alpha: isDarkMode ? 0.1 : 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: () {
          final newTheme = isDarkMode ? 'light' : 'dark';
          themeProvider.setThemeMode(newTheme);
        },
        icon: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          size: 22,
          color: theme.iconTheme.color ?? colorScheme.onSurface,
        ),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        padding: const EdgeInsets.all(8),
        tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
      ),
    );
  }
}
