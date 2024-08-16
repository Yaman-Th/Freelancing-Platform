import 'package:flutter/material.dart';
import 'package:freelancing/chat/inside_chat.dart';

class ChatListScreen extends StatelessWidget {
  final List<Map<String, String>> chats = [
    {
      "name": "Bader",
      "message": "Hello",
      "time": "just now",
      "avatarUrl": "https://via.placeholder.com/150",
      "isSentByMe": "false"
    },
    {
      "name": "Bsher",
      "message": "Hi",
      "time": "1 hour ago",
      "avatarUrl": "https://via.placeholder.com/150",
      "isSentByMe": "true"
    },
    {
      "name": "Yaman",
      "message": "How are u?",
      "time": "1 hour ago",
      "avatarUrl": "https://via.placeholder.com/150",
      "isSentByMe": "true"
    },
    {
      "name": "Karam",
      "message": "F*** gitHub again 😂😂",
      "time": "2 hours ago",
      "avatarUrl": "https://via.placeholder.com/150",
      "isSentByMe": "false"
    },
    {
      "name": "Ahmad m",
      "message": "وين التقريرر",
      "time": "2000 years ago",
      "avatarUrl": "https://via.placeholder.com/150",
      "isSentByMe": "false"
    },
  ];

  final List<Map<String, String>> favorites = [
    {"name": "Bader", "avatarUrl": "https://via.placeholder.com/150"},
    {"name": "Bsher", "avatarUrl": "https://via.placeholder.com/150"},
    {"name": "Yaman", "avatarUrl": "https://via.placeholder.com/150"},
    {"name": "Karam", "avatarUrl": "https://via.placeholder.com/150"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Chat'),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.settings),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Theme.of(context).colorScheme.background),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.background,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
              height: 100.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final favorite = favorites[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(favorite["avatarUrl"]!),
                        ),
                        const SizedBox(height: 5.0),
                        Text(favorite["name"]!,
                            style: const TextStyle(fontSize: 12.0)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text('Your Space',
          //         style:
          //             TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
          //   ),
          // ),
          ListTile(
            onTap: () {},
            leading: Icon(Icons.bookmark, color: Theme.of(context).colorScheme.onSurface),
            title: const Text('Saved Messages'),
            subtitle: const Text('project1.dart'),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatScreen()));
                  },
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(chat["avatarUrl"]!),
                  ),
                  title: Text(chat["name"]!),
                  subtitle: Row(
                    children: [
                      Text(chat["isSentByMe"] == "true" ? "You: " : ""),
                      Text(chat["message"]!),
                    ],
                  ),
                  trailing: Text(chat["time"]!),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).colorScheme.onSurface,
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.background,
        ),
      ),
    );
  }
}
