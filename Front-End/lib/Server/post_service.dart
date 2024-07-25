import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Post {
  final String title;
  final String description;
  final String deadline;
  final int budget;
  final String type;

  Post(
      {required this.title,
      required this.description,
      required this.deadline,
      required this.budget,
      required this.type});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'],
      description: json['description'],
      budget: json['budget'],
      deadline: json['deadline'],
      type: json['type'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'budget': budget,
      'deadline': deadline,
      'type': type,
    };
  }

  Future<Post> createPost(Post post) async {
    final response = await http.post(
      Uri.parse('http://localhost:8000/api/posts'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<List<Post>> getAllPosts() async {
    final url = Uri.parse('http://localhost/api/services');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
  }

