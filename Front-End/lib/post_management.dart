import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelancing/Server/post_service.dart';
import 'package:freelancing/main.dart';
import 'package:http/http.dart' as http;

class PostManagement extends StatefulWidget {
  const PostManagement({super.key});

  @override
  State<PostManagement> createState() => PostManagementState();
}

class PostManagementState extends State<PostManagement> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  String? _selectedType;
  final List<String> _types = ['job', 'freelance'];
  List<Map<String, dynamic>> posts = [];
  int? editingIndex;

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 2, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, child) {
        return Theme(
          data: ThemeData().copyWith(
            colorScheme: ColorScheme.light(
                primary: colorScheme.primary,
                onPrimary: colorScheme.onSecondary,
                surface: colorScheme.onSurface,
                onSurface: colorScheme.background),
            dialogBackgroundColor: colorScheme.background,
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  backgroundColor: colorScheme.background,
                  textStyle: TextStyle(color: colorScheme.background),
                  disabledForegroundColor: colorScheme.background),
            ),
            inputDecorationTheme: InputDecorationTheme(
              fillColor: colorScheme.background,
              labelStyle: TextStyle(color: colorScheme.background),
              focusColor: colorScheme.background,
              hintStyle: TextStyle(color: colorScheme.background),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorScheme.background),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorScheme.background),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _deadlineController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.1.8:8000/api/posts'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(post.toJson()),
      );
      if (response.statusCode == 201 || response.statusCode == 200 ) {
        final newPost = Post.fromJson(jsonDecode(response.body));
        setState(() {
          posts.add(newPost.toJson());
        });
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to create post');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _fetchPosts() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.8:8000/api/posts'));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<Post> postsList =
            body.map((dynamic item) => Post.fromJson(item)).toList();
        setState(() {
          posts = postsList.map((post) => post.toJson()).toList();
        });
      } else {
        print('Failed to login. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to load posts');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPosts(); 
  }

  // void _handlePost() {
  //   if (_formKey.currentState!.validate()) {
  //     setState(() {
  //       if (editingIndex != null) {
  //         posts[editingIndex!] = {
  //           'title': _titleController.text,
  //           'description': _descriptionController.text,
  //           'type': _selectedType,
  //           'budget': _budgetController.text,
  //           'deadline': _deadlineController.text,
  //         };
  //         editingIndex = null;
  //       } else {
  //         posts.add({
  //           'title': _titleController.text,
  //           'description': _descriptionController.text,
  //           'type': _selectedType,
  //           'budget': _budgetController.text,
  //           'deadline': _deadlineController.text,
  //         });
  //       }
  //       _titleController.clear();
  //       _descriptionController.clear();
  //       _typeController.clear();
  //       _budgetController.clear();
  //       _deadlineController.clear();
  //     });
  //   }
  // }
  void _handlePost() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        title: _titleController.text,
        description: _descriptionController.text,
        type: _selectedType!,
        budget: int.parse(_budgetController.text),
        deadline: _deadlineController.text,
      );

      if (editingIndex != null) {
      } else {
        _createPost(newPost);
      }

      setState(() {
        _titleController.clear();
        _descriptionController.clear();
        _typeController.clear();
        _budgetController.clear();
        _deadlineController.clear();
        editingIndex = null;
      });
    }
  }

  void _handleEdit(int index) {
    setState(() {
      editingIndex = index;
      _titleController.text = posts[index]['title'];
      _descriptionController.text = posts[index]['description'];
      _selectedType = posts[index]['type'];
      _budgetController.text = posts[index]['budget'];
      _deadlineController.text = posts[index]['deadline'];
    });
  }

  void _handleDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(
            'Confirm Delete',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          content: Text(
            'Are you sure you want to delete this post?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.red,
                    ),
              ),
              onPressed: () {
                setState(() {
                  posts.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create a Post',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient:LinearGradient(colors: [
                    colorScheme.onSurface,
                    colorScheme.onSecondary,
                    colorScheme.onPrimary
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  ) ,
                  //color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Title',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Description',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        value: _selectedType,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                        decoration: InputDecoration(
                          hintText: 'Type',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                          border: InputBorder.none,
                        ),
                        items: _types.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Container(
                              color: Theme.of(context).colorScheme.onSecondary,
                              child: Text(
                                value,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedType = newValue!;
                          });
                        },
                        dropdownColor:
                            Theme.of(context).colorScheme.onSecondary,
                        validator: (value) {
                          if (value == null) {
                            return 'Please select a type';
                          }
                          return null;
                        },
                        iconEnabledColor:
                            Theme.of(context).colorScheme.background,
                        iconSize: 30,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _budgetController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Budget',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a budget';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _deadlineController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: 'Deadline',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Theme.of(context).colorScheme.background,
                            ),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a deadline';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: _handlePost,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                          ),
                          child: Text(
                            editingIndex != null ? 'Save' : 'Post',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your latest posts',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 20),
              posts.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return Card(
                          color: Theme.of(context).colorScheme.onSurface,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Post ${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                Text('Title: ${post['title']}'),
                                Text('Description: ${post['description']}'),
                                Text('Type: ${post['type']}'),
                                Text('Budget: ${post['budget']}'),
                                Text('Deadline: ${post['deadline']}'),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _handleEdit(index),
                                      child: Text(
                                        'Edit',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                      onPressed: () => _handleDelete(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Column(
                      children: [
                        Text(
                          'No posts yet',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Icon(
                          Icons.error_sharp,
                          color: colorScheme.onSurface,
                          size: 75,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
