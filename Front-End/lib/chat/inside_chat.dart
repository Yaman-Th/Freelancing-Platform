import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatelessWidget {
  void setupPushNotifications() async {
    final fcm = FirebaseMessaging.instance;

    await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
  }

  final List<Map<String, dynamic>> messages = [
    {"isSentByMe": false, "text": "hi how are u", "time": "09:30 PM"},
    {"isSentByMe": true, "text": "fine and u?", "time": "09:31 PM"},
    {"isSentByMe": false, "text": "fine to thx!", "time": "09:31 PM"},
    {"isSentByMe": false, "text": "will u finish the UI??", "time": "09:35 PM"},
    {"isSentByMe": true, "text": "NO😊", "time": "09:36 PM"},
    {"isSentByMe": false, "text": "why!!!!!!!", "time": "09:36 PM"},
    {
      "isSentByMe": true,
      "text": "because i need my money first",
      "time": "09:37 PM"
    },
    {"isSentByMe": false, "text": "GO TO HELL", "time": "09:31 PM"},
    {"isSentByMe": true, "text": "OK", "time": "09:31 PM"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ahmad', style: TextStyle(fontSize: 16)),
                Text('Online',
                    style: TextStyle(fontSize: 12, color: Colors.green))
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message['isSentByMe']
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: message['isSentByMe']
                          ? Theme.of(context).colorScheme.onSurface
                          : Theme.of(context).colorScheme.onTertiary,
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.containsKey('image'))
                          Container(
                            margin: const EdgeInsets.only(bottom: 5.0),
                            child: Image.network(message['image']),
                          ),
                        Text(
                          message['text'],
                          style: TextStyle(
                            color: message['isSentByMe']
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          message['time'],
                          style: TextStyle(
                            color: message['isSentByMe']
                                ? Colors.white70
                                : Colors.black54,
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type here...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.onTertiary,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send,
                      color: Theme.of(context).colorScheme.onSurface),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
