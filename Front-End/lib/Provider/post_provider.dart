import 'package:flutter/material.dart';
import 'package:freelancing/models/post.dart';
import 'package:freelancing/Server/post_service.dart';

class PostProvider with ChangeNotifier {
  final PostService _postService;
  List<Post> _posts = [];
  bool _isLoading = false;
  String? _errorMessage;

  PostProvider(this._postService);

  List<Post> get posts => _posts;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();
    try {
      _posts = await _postService.fetchPosts();
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> createPost(Post post) async {
    _isLoading = true;
    notifyListeners();
    try {
      final newPost = await _postService.createPost(post);
      _posts.add(newPost);
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> deletePost(int index) async {
    final postId = _posts[index].id; // Assuming `id` field exists in Post model
    _isLoading = true;
    notifyListeners();
    try {
      await _postService.deletePost(postId!);
      _posts.removeAt(index);
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }

  Future<void> editPost(int index, Post updatedPost) async {
    final postId = _posts[index].id; // Assuming `id` field exists in Post model
    _isLoading = true;
    notifyListeners();
    try {
      final editedPost = await _postService.editPost(postId!, updatedPost);
      _posts[index] = editedPost;
      _isLoading = false;
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
    }
    notifyListeners();
  }
}
