// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/config/theme/theme_provider.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: ListView(
          children: [
            // SHOW THEME/UPDATE THEME SWITCH
            SwitchListTile(
              title: Text('App Theme'),
              value: isDarkTheme,
              onChanged: (value) {
                ref.read(isDarkThemeProvider.notifier).state = value;
              },
            ),
            // NOTIFICATIONS
            ListTile(
              title: Text('Notifications'),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/notification-setting');
              },
            ),
          ],
        ),
      ),
    );
  }
}
