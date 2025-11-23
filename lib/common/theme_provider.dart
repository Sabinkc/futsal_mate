import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:futsalmate/common/colors.dart';

// Theme modes
enum AppTheme { light, dark, system }

// Theme provider
final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  ThemeNotifier() : super(AppTheme.light);

  void setTheme(AppTheme theme) {
    state = theme;
  }
}

// Theme data
final themeDataProvider = Provider<ThemeData>((ref) {
  final themeMode = ref.watch(themeProvider);

  switch (themeMode) {
    case AppTheme.dark:
      return _darkTheme;
    case AppTheme.system:
      // You can implement system theme detection here
      return _lightTheme;
    case AppTheme.light:
    default:
      return _lightTheme;
  }
});

// Light theme
final ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: CommonColors.primaryColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    backgroundColor: CommonColors.primaryColor,
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.light(
    primary: CommonColors.primaryColor,
    secondary: CommonColors.primaryColor,
  ),
);

// Dark theme
final ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: CommonColors.primaryColor,
  scaffoldBackgroundColor: Colors.grey[900],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
  ),
  colorScheme: ColorScheme.dark(
    primary: CommonColors.primaryColor,
    secondary: CommonColors.primaryColor,
  ),
);
