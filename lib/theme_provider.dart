import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themePreferenceKey = 'theme_preference';

  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadThemePreference();
  }

  Future<void> _loadThemePreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? themePreference = prefs.getString(_themePreferenceKey);

    if (themePreference == 'light') {
      _themeMode = ThemeMode.light;
    } else if (themePreference == 'dark') {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String preference;

    switch (mode) {
      case ThemeMode.light:
        preference = 'light';
        break;
      case ThemeMode.dark:
        preference = 'dark';
        break;
      default:
        preference = 'system';
    }

    await prefs.setString(_themePreferenceKey, preference);
  }

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    setThemeMode(
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
