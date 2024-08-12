import 'package:flutter/material.dart';
import 'package:freelancing/models/notification.dart';
import 'package:freelancing/widget/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() {
    return _NotificationScreenState();
  }
}

List<Notification1> notifications = [
  Notification1(initial: 'A', title: 'List item'),
  Notification1(initial: 'A', title: 'List item'),
  Notification1(initial: 'A', title: 'List item'),
  Notification1(initial: 'A', title: 'List item'),
  Notification1(initial: 'A', title: 'List item'),
  Notification1(initial: 'A', title: 'List item'),
];

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'There is no notification yet!',
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5)),
      ),
    );
    if (notifications.isNotEmpty) {
      mainContent = ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: ValueKey(notifications[index]),
            direction: DismissDirection.endToStart,
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            child: NotificationItem(
              notification: notifications[index],
              onRemove: () {
                setState(() {
                  notifications.removeAt(index);
                });
              },
            ),
          );
        },
      );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Notification',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary, fontSize: 27),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/Avatar.png'),
              ),
            ),
          ],
        ),
        body: mainContent);
  }
}
