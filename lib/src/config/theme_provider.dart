import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString('theme_mode') ?? 'system';

    setThemeMode(themeName);
  }

  Future<void> _saveThemeToPrefs(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('theme_mode', themeName);
  }

  void setThemeMode(String themeName) {
    ThemeMode mode;

    switch (themeName) {
      case 'light':
        mode = ThemeMode.light;
        break;
      case 'dark':
        mode = ThemeMode.dark;
        break;
      default:
        mode = ThemeMode.system;
    }

    _themeMode = mode;
    _saveThemeToPrefs(themeName);
    notifyListeners();
  }
}
