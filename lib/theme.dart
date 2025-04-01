import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Colors for light theme
const Color _lightPrimaryColor = Color(0xFF6200EE);
const Color _lightSecondaryColor = Color(0xFF03DAC6);
const Color _lightBackgroundColor = Color(0xFFFAFAFA);
const Color _lightSurfaceColor = Colors.white;
const Color _lightErrorColor = Color(0xFFB00020);

// Colors for dark theme
const Color _darkPrimaryColor = Color(0xFFBB86FC);
const Color _darkSecondaryColor = Color(0xFF03DAC6);
const Color _darkBackgroundColor = Color(0xFF121212);
const Color _darkSurfaceColor = Color(0xFF1E1E1E);
const Color _darkErrorColor = Color(0xFFCF6679);

// Light Theme
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: _lightPrimaryColor,
    onPrimary: Colors.white,
    secondary: _lightSecondaryColor,
    onSecondary: Colors.black,
    error: _lightErrorColor,
    onError: Colors.white,
    background: _lightBackgroundColor,
    onBackground: Colors.black,
    surface: _lightSurfaceColor,
    onSurface: Colors.black,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme),
  appBarTheme: const AppBarTheme(
    backgroundColor: _lightPrimaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: _lightPrimaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _lightSecondaryColor,
    foregroundColor: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: _lightPrimaryColor,
    unselectedItemColor: Colors.grey,
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: _darkPrimaryColor,
    onPrimary: Colors.black,
    secondary: _darkSecondaryColor,
    onSecondary: Colors.black,
    error: _darkErrorColor,
    onError: Colors.black,
    background: _darkBackgroundColor,
    onBackground: Colors.white,
    surface: _darkSurfaceColor,
    onSurface: Colors.white,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
  appBarTheme: AppBarTheme(
    backgroundColor: _darkSurfaceColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  cardTheme: CardTheme(
    elevation: 2,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: _darkPrimaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: _darkSecondaryColor,
    foregroundColor: Colors.black,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: _darkPrimaryColor,
    unselectedItemColor: Colors.grey,
  ),
);
