import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:testeeeer/karamffolder/colors.dart';
import 'package:testeeeer/karamffolder/create_a_service.dart';
import 'package:testeeeer/karamffolder/poost.dart';

class getMyServiceScreen extends StatefulWidget {
  @override
  _getMyServiceScreenState createState() => _getMyServiceScreenState();
}

class _getMyServiceScreenState extends State<getMyServiceScreen> {
  List<MyServices> myservice = [];
  bool isLoading = true;
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

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
        Uri.parse('http://192.168.43.21:8000/api/myservices'),
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
                servicesJson.map((json) => MyServices.fromJson(json)).toList();
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
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define your base URL (make sure it ends with a '/')
    //const String baseUrl = 'http://192.168.137.58:8000/';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Survices'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
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
                Expanded(
                  child: ListView.builder(
                    itemCount: myservice.length,
                    itemBuilder: (context, index) {
                      final my = myservice[index];

                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              my.image != null && my.image!.isNotEmpty
                                  ? Image.network(
                                      '$my.image',
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        // Fallback widget in case of an error
                                        return Icon(Icons.image_not_supported,
                                            size: 50, color: Colors.grey);
                                      },
                                    )
                                  : Icon(Icons.image_not_supported,
                                      size: 50, color: Colors.grey),
                              Text(
                                my.title ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(my.description ?? 'No Description'),
                              SizedBox(height: 5),
                              Text(
                                '\$${my.price ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              Text(
                                '${my.deliveryDayes ?? 'N/A'} days',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: IndigoDye,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Posted by ${my.freelancerId} on ${my.createdAt}',
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
                ),
                Container(
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ServiceScreen();
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: Aquamarine,
                      )),
                ),
              ],
            ),
    );
  }
}

class MyServices {
  int? id;
  int? freelancerId;
  String? title;
  String? description;
  String? image;
  int? deliveryDayes;
  int? price;
  int? categoryId;
  String? createdAt;
  String? updatedAt;

  MyServices(
      {this.id,
      this.freelancerId,
      this.title,
      this.description,
      this.image,
      this.deliveryDayes,
      this.price,
      this.categoryId,
      this.createdAt,
      this.updatedAt});

  MyServices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    freelancerId = json['freelancer_id'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    deliveryDayes = json['delivery_dayes'];
    price = json['price'];
    categoryId = json['category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['freelancer_id'] = this.freelancerId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['delivery_dayes'] = this.deliveryDayes;
    data['price'] = this.price;
    data['category_id'] = this.categoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
