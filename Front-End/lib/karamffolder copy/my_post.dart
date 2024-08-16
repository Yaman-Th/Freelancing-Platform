import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testeeeer/karamffolder/colors.dart';
import 'package:http/http.dart' as http;
import 'package:testeeeer/karamffolder/poost.dart';

class myPost extends StatefulWidget {
  const myPost({super.key});

  @override
  State<myPost> createState() => _myPostState();
}

class _myPostState extends State<myPost> {
  List<mypost> myservice = [];
  bool isLoading = true;
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    fetchMyServices();
  }

  Future<void> fetchMyServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://192.168.43.21:8000/api/posts/mypost'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        try {
          // Decode the JSON response into a List
          final List<dynamic> servicesJson = json.decode(response.body);

          setState(() {
            // Map each service JSON to a MyServices object
            myservice =
                servicesJson.map((json) => mypost.fromJson(json)).toList();
            isLoading = false;
          });
        } catch (e) {
          print('Failed to decode response: $e');
          setState(() {
            isLoading = false;
          });
        }
      } else {
        print('Failed to load posts, status code: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    } else {
      print('Token is null');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Home'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: myservice.length,
                    itemBuilder: (context, index) {
                      final post = myservice[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post.title ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(post.description ?? 'No Description'),
                              SizedBox(height: 5),
                              Text(
                                '\$${post.budget ?? 'N/A'}',
                                style: TextStyle(
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
                              SizedBox(height: 5),
                              Text(
                                'Posted by ${post.clientId} on ${post.createdAt}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
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
                                return post();
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

class mypost {
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

  mypost(
      {this.id,
      this.clientId,
      this.title,
      this.description,
      this.type,
      this.budget,
      this.deadline,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  mypost.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
