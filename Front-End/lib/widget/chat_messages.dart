import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/utils/token.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:freelancing/widget/message_bubble.dart';

class ChatMessages extends StatelessWidget {
  const ChatMessages({super.key});

  Future<String> _getCurrentUserId() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/my'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final userData = json.decode(response.body);
      return userData['id'].toString();
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getCurrentUserId(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Failed to load messages.'));
        }

        final authenticatedUserId = snapshot.data!;

        return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (ctx, chatSnapshots) {
            if (chatSnapshots.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!chatSnapshots.hasData || chatSnapshots.data!.docs.isEmpty) {
              return const Center(child: Text('No messages found.'));
            }

            if (chatSnapshots.hasError) {
              return const Center(child: Text('Something went wrong...'));
            }

            final loadedMessages = chatSnapshots.data!.docs;

            return ListView.builder(
              padding: const EdgeInsets.only(
                bottom: 40,
                left: 13,
                right: 13,
              ),
              reverse: true,
              itemCount: loadedMessages.length,
              itemBuilder: (ctx, index) {
                final chatMessage = loadedMessages[index].data();
                final nextChatMessage = index + 1 < loadedMessages.length
                    ? loadedMessages[index + 1].data()
                    : null;

                final currentMessageUserId = chatMessage['userId'];
                final nextMessageUserId =
                    nextChatMessage != null ? nextChatMessage['userId'] : null;
                final nextUserIsSame = nextMessageUserId == currentMessageUserId;

                if (nextUserIsSame) {
                  return MessageBubble.next(
                    message: chatMessage['text'],
                    isMe: authenticatedUserId == currentMessageUserId,
                  );
                } else {
                  return MessageBubble.first(
                    userImage: chatMessage['userImage'],
                    username: chatMessage['username'],
                    message: chatMessage['text'],
                    isMe: authenticatedUserId == currentMessageUserId,
                  );
                }
              },
            );
          },
        );
      },
    );
  }
}
