import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freelancing/constant/colors.dart';
import 'package:freelancing/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:freelancing/Screens/Post/post_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Home> posts = [];
  List<Category> categories = [];
  bool isLoading = true;
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchPosts();
    fetchCategories();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < (categories.length / 6).ceil() - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  Future<void> fetchPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://localhost:8000/api/allpost'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseBody = response.body;
        print('Response body: $responseBody'); // Log the response body

        try {
          final List<dynamic> parsedJson = json.decode(responseBody);

          // Flatten the nested lists
          final List<dynamic> flattenedList =
              parsedJson.expand((i) => i).toList();

          setState(() {
            posts = flattenedList.map((json) => Home.fromJson(json)).toList();
            isLoading = false;
          });
        } catch (e) {
          print('Failed to decode response: $e');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        print('Failed to load posts, status code: ${response.statusCode}');
      }
    } else {
      setState(() {
        isLoading = false;
      });
      print('Token is null');
    }
  }

  Future<void> fetchCategories() async {
    final response = await http.get(
      Uri.parse('http://localhost:8000/api/categories'),
    );

    if (response.statusCode == 200) {
      final responseBody = response.body;
      print('Category response body: $responseBody');

      try {
        final List<dynamic> parsedJson = json.decode(responseBody);

        setState(() {
          categories =
              parsedJson.map((json) => Category.fromJson(json)).toList();
        });
      } catch (e) {
        print('Failed to decode categories: $e');
      }
    } else {
      print('Failed to load categories, status code: ${response.statusCode}');
      print(response.body);
    }
  }

  final commentController = TextEditingController();

  Future<void> _proposal(
    String post_id,
    String comment,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http.post(
      Uri.parse('http://localhost:8000/api/proposals'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'post_id': post_id,
        'comment': comment,
      },
    );

    if (response.statusCode == 200) {
      print('Order placed successfully');
    } else {
      print('Failed to place order, status code: ${response.statusCode}');
      print(response.body);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          actions: [IconButton(onPressed: () {
          Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const PostScreen();
        },
      ),
    );
        }, icon: const Icon(Icons.add))],
        title: const Text('Home'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search posts...',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100, // Adjust height as needed
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: (categories.length / 5).ceil(),
                      itemBuilder: (context, index) {
                        int start = index * 5;
                        int end = start + 5;
                        List<Category> categoryPage = categories.sublist(
                          start,
                          end > categories.length ? categories.length : end,
                        );
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: categoryPage.map((category) {
                            return Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: IndigoDye,
                                  child: Text(
                                    category.name![0].toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  category.name!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                            fontSize: 10,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      return Card(
                        color: Theme.of(context).colorScheme.secondary,
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title ?? 'No Title',
                                style:  TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme.onSecondary
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(post.description ?? 'No Description',style: TextStyle(color:colorScheme.primary ),),
                              const SizedBox(height: 5),
                              Text(
                                '\$${post.budget ?? 'N/A'}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                '${post.type ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: IndigoDye,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Posted by ${post.clientId} on ${post.createdAt}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Make An Order'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller: commentController,
                                                decoration: InputDecoration(
                                                  hintText: 'Comment',
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    borderSide: BorderSide(
                                                        color: BlueGray),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide: BorderSide(
                                                        color: BlueGray),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () async {
                                                await _proposal(
                                                    post.id.toString(),
                                                    commentController.text);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Submit'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Text(
                                    'submit',
                                    style: TextStyle(
                                        color: Aquamarine,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  //Color: Aquamarine,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const PostScreen();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.add_circle_outline,
                          color: Aquamarine,
                        )),
                  )
                ],
              ),
            ),
    );
  }
}

class Home {
  int? id;
  int? clientId;
  String? title;
  String? description;
  String? type;
  int? budget;
  String? deadline;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  Home(
      {this.id,
      this.clientId,
      this.title,
      this.description,
      this.type,
      this.budget,
      this.deadline,
      this.categoryId,
      this.createdAt,
      this.updatedAt,
      this.imageUrl});

  Home.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    clientId = json['client_id'];
    title = json['title'];
    description = json['description'];
    type = json['type'];
    budget = json['budget'];
    deadline = json['deadline'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['client_id'] = this.clientId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['type'] = this.type;
    data['budget'] = this.budget;
    data['deadline'] = this.deadline;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Category {
  int? id;
  String? name;
  int? parentId;
  String? createdAt;
  String? updatedAt;
  List<Children>? children;

  Category(
      {this.id,
      this.name,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.children});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['children'] != null) {
      children = <Children>[];
      json['children'].forEach((v) {
        children!.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.children != null) {
      data['children'] = this.children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Children {
  int? id;
  String? name;
  int? parentId;
  String? createdAt;
  String? updatedAt;

  Children({this.id, this.name, this.parentId, this.createdAt, this.updatedAt});

  Children.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
