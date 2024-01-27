import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/config/notification/notification.dart';
import 'package:fluxpense/presentation/pages/add_expense_screen.dart';
import 'package:fluxpense/presentation/pages/all_expenses_screen.dart';
import 'package:fluxpense/presentation/pages/settings/notification_setting_screen.dart';
import 'package:fluxpense/presentation/pages/settings/settings_screen.dart';
import 'package:fluxpense/presentation/pages/view_expense_screen.dart';
import 'package:fluxpense/config/theme/theme_provider.dart';
import 'package:fluxpense/config/theme/theme.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'presentation/pages/home_screen.dart';
import 'presentation/pages/splash_screen/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationManager.init();

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode =
        ref.watch(themeModeProvider.notifier); //For updating theme
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fluxpense',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/add-expense': (context) => const AddExpenseScreen(),
        '/all-expenses': (context) => const AllExpensesScreen(),
        '/view-expense': (context) => const ViewExpenseScreen(),
        '/settings': (context) => const SettingsScreen(),
        '/notification-setting': (context) => const NotificationSettingScreen(),
      },
      themeMode: themeMode.state,
    );
  }
}
