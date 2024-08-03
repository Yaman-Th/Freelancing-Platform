import 'dart:convert';
import 'package:freelancing/utils/token.dart';
import 'package:http/http.dart' as http;
import 'package:freelancing/models/post.dart';

class PostService {
  static const String _baseUrl = 'http://192.168.1.6:8000/api/posts';
  
  Future<List<Post>> fetchPosts() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Post.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post> createPost(Post post) async {
    final token = await TokenStorage.getToken();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print('done');
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<void> deletePost(int id) async {
    final token = await TokenStorage.getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete post');
    }
  }

  Future<Post> editPost(int id, Post post) async {
    final token = await TokenStorage.getToken();
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Authorization':'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(post.toJson()),
    );
    if (response.statusCode == 200) {
      return Post.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update post');
    }
  }
}
