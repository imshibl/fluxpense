import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/data/data_sources/local_database.dart';

// Theme Mode Provider
final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final isDarkTheme = ref.watch(isDarkThemeProvider);
  if (isDarkTheme) {
    sharedPreferences.value?.setString('themeMode', "dark");
  } else {
    sharedPreferences.value?.setString('themeMode', "light");
  }
  final themeModeString = sharedPreferences.value?.getString("themeMode");

  return themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
});

// Theme Switch Provider
final isDarkThemeProvider = StateProvider<bool>((ref) {
  final sharedPreferences = ref.watch(sharedPreferencesProvider);
  final themeModeString = sharedPreferences.value?.getString("themeMode");
  return themeModeString == 'dark' ? true : false;
});
