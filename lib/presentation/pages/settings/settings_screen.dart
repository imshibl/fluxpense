import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/config/theme/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme =
        ref.watch(isDarkThemeProvider); //to switch theme(light/dark)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: ListView(
          children: [
            // SHOW THEME UPDATE SWITCH
            SwitchListTile(
              title: const Text('App Theme'),
              value: isDarkTheme,
              onChanged: (value) {
                // Update theme
                ref.read(isDarkThemeProvider.notifier).state = value;
              },
            ),
            // NOTIFICATIONS
            ListTile(
              title: const Text('Notifications'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () {
                // Navigate to notification setting
                Navigator.of(context).pushNamed('/notification-setting');
              },
            ),
          ],
        ),
      ),
    );
  }
}
