import 'dart:convert';

class Post {
  final int? id; 
  final String title;
  final String description;
  final String deadline;
  final double budget;
  final String type;

  Post({
    this.id,
    required this.title,
    required this.description,
    required this.deadline,
    required this.budget,
    required this.type,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      budget: json['budget'],
      deadline: json['deadline'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'budget': budget,
      'deadline': deadline,
      'type': type,
    };
  }
}
