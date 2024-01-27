import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluxpense/config/notification/notification.dart';

class NotificationSettingScreen extends ConsumerStatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState
    extends ConsumerState<NotificationSettingScreen> {
  TimeOfDay _selectedTime = const TimeOfDay(hour: 17, minute: 0);

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return TimeOfDay.fromDateTime(dateTime).format(context);
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
      NotificationManager.showScheduledNotification(
        title: "Notification",
        body: "This is a notification",
        payload: "This is a payload",
        scheduledTime: _selectedTime,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notification'),
        ),
        body: Column(
          children: [
            ListTile(
              title: const Text("Daily reminder"),
              subtitle: Text(
                  "Remind me to add expenses at ${_formatTimeOfDay(_selectedTime)} ."),
              trailing: IconButton(
                onPressed: () {
                  _showTimePicker();
                },
                icon: const Icon(Icons.timer),
              ),
            ),
          ],
        ));
  }
}
