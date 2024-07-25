import 'package:flutter/material.dart';
import 'package:freelancing/models/notification.dart';

class NotificationItem extends StatelessWidget {
  final Notification1 notification;
  final VoidCallback onRemove;
  const NotificationItem({super.key, required this.notification, required this.onRemove});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.background,
              child: Text(
                notification.initial,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                notification.title,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
            InkWell(
              onTap: onRemove,
              child: Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
