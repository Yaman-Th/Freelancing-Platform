import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/models/post.dart';

final postNotifierProvider = StateNotifierProvider<PostNotifier, List<Post>>((ref) {
  return PostNotifier();
});

class PostNotifier extends StateNotifier<List<Post>> {
  PostNotifier() : super([]);

  // Fetch all posts
  Future<void> fetchPosts() async {
    try {
      // Simulate fetching posts (e.g., from a local database or a predefined list)
      List<Post> posts = [
        Post(id: 1, title: "Flutter Developer Needed", description: "Develop a mobile app", type: "freelance", budget: 500.0, deadline: "2024-12-01", category: 1),
        Post(id: 2, title: "Website Design", description: "Design a responsive website", type: "job", budget: 1000.0, deadline: "2024-11-15", category: 2),
        // Add more posts as needed
      ];
      state = posts;
    } catch (e) {
      // Handle error
    }
  }

  // Create a new post
  Future<void> createPost(Post post) async {
    try {
      // Simulate creating a post
      final newPost = Post(
        id: state.length + 1,
        title: post.title,
        description: post.description,
        type: post.type,
        budget: post.budget,
        deadline: post.deadline,
        category: post.category,
      );
      state = [...state, newPost];
    } catch (e) {
      // Handle error
    }
  }

  // Delete a post by ID
  Future<void> deletePost(int index) async {
    try {
   state = [
      for (int i = 0; i < state.length; i++)
        if (i != index) state[i],
    ];
    } catch (e) {
      // Handle error
    }
  }

  // Edit an existing post by ID
  Future<void> editPost(int postId, Post updatedPost) async {
    try {
      // Simulate editing a post
      state = [
        for (final post in state)
          if (post.id == postId) 
            Post(
              id: post.id,
              title: updatedPost.title,
              description: updatedPost.description,
              type: updatedPost.type,
              budget: updatedPost.budget,
              deadline: updatedPost.deadline,
              category: updatedPost.category,
            )
          else 
            post
      ];
    } catch (e) {
      // Handle error
    }
  }
}
