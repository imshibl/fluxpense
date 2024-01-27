import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  final isDarkTheme = ref.watch(isDarkThemeProvider);
  if (isDarkTheme) {
    sharedPreferences.value?.setString('themeMode', "dark");
  } else {
    sharedPreferences.value?.setString('themeMode', "light");
  }
  final themeModeString = sharedPreferences.value?.getString("themeMode");

  return themeModeString == 'dark' ? ThemeMode.dark : ThemeMode.light;
});

final isDarkThemeProvider = StateProvider<bool>((ref) {
  final sharedPreferences = ref.read(sharedPreferencesProvider);
  final themeModeString = sharedPreferences.value?.getString("themeMode");
  return themeModeString == 'dark' ? true : false;
});

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
  return await SharedPreferences.getInstance();
});
