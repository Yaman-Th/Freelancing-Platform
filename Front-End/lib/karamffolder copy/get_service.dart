import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:testeeeer/karamffolder/colors.dart';
import 'package:testeeeer/karamffolder/create_a_service.dart';
import 'package:testeeeer/karamffolder/poost.dart';

class GetServiceScreen extends StatefulWidget {
  @override
  _GetServiceScreenState createState() => _GetServiceScreenState();
}

class _GetServiceScreenState extends State<GetServiceScreen> {
  List<Service> services = [];
  List<Category> categories = [];
  bool isLoading = true;
  PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final orderQuantityController = TextEditingController();
  final deliveryDateController = TextEditingController();
  final detailsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchServices();
    fetchCategories();
    _startCategorySlider();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    orderQuantityController.dispose();
    deliveryDateController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  Future<void> fetchServices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://192.168.137.150:8000/api/services'),
        headers: {'Authorization': 'Bearer $token'},
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('yes');
        try {
          final List<dynamic> servicesJson =
              json.decode(response.body)['services'];
          setState(() {
            services =
                servicesJson.map((json) => Service.fromJson(json)).toList();
            isLoading = false;
          });
        } catch (e) {
          print('Failed to decode response: $e');
          setState(() => isLoading = false);
        }
      } else {
        print('Failed to load services, status code: ${response.statusCode}');
        setState(() => isLoading = false);
      }
    } else {
      print('Token is null');
      setState(() => isLoading = false);
    }
  }

  Future<void> fetchCategories() async {
    final response =
        await http.get(Uri.parse('http://192.168.137.150:8000/api/categories'));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> categoriesJson = json.decode(response.body);
        setState(() {
          categories =
              categoriesJson.map((json) => Category.fromJson(json)).toList();
        });
      } catch (e) {
        print('Failed to decode categories: $e');
      }
    } else {
      print('Failed to load categories, status code: ${response.statusCode}');
    }
  }

  void _startCategorySlider() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < (categories.length / 5).ceil() - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  Future<void> _order(
    String serviceId,
    String deliveryDate,
    String quantity,
    String details,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response = await http.post(
      Uri.parse('http://192.168.137.150:8000/api/orders'),
      headers: {'Authorization': 'Bearer $token'},
      body: {
        'service_id': serviceId,
        'delivery_date': deliveryDate,
        'quantity': quantity,
        'details': details,
      },
    );

    if (response.statusCode == 200) {
      print('Order placed successfully');
    } else {
      print('Failed to place order, status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Home')),
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
                SizedBox(
                  height: 100,
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
                              SizedBox(height: 20),
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: IndigoDye,
                                child: Text(
                                  category.name![0].toUpperCase(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                category.name!,
                                style: TextStyle(fontSize: 8),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: services.length,
                    itemBuilder: (context, index) {
                      final service = services[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Check if imageUrl is not null
                              Center(
                                child: Image.network(
                                  '${service.imageUrl}',
                                  height: 150, // Set desired height
                                  width: double.infinity, // Occupy full width
                                  fit: BoxFit.cover, // Maintain aspect ratio
                                ),
                              ),
                              SizedBox(
                                  height: 10), // Space between image and text
                              Text(
                                service.title ?? 'No Title',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(service.description ?? 'No Description'),
                              SizedBox(height: 5),
                              Text(
                                '\$${service.price ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(height: 5),
                              Center(
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Make An Order'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextFormField(
                                                controller:
                                                    orderQuantityController,
                                                decoration: InputDecoration(
                                                  hintText: 'Quantity',
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
                                              SizedBox(height: 20),
                                              TextFormField(
                                                controller: detailsController,
                                                decoration: InputDecoration(
                                                  hintText: 'Details',
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
                                              SizedBox(height: 20),
                                              TextFormField(
                                                controller:
                                                    deliveryDateController,
                                                decoration: InputDecoration(
                                                  hintText: 'Delivery Date',
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
                                                await _order(
                                                  service.id.toString(),
                                                  deliveryDateController.text,
                                                  orderQuantityController.text,
                                                  detailsController.text,
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              child: Text('Submit'),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: IndigoDye,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Order Now',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}

class Service {
  final int? id;
  final String? title;
  final String? description;
  final String? price;
  final String? imageUrl; // Add imageUrl field

  Service({this.id, this.title, this.description, this.price, this.imageUrl});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      title: json['title']?.toString(),
      description: json['description']?.toString(),
      price: json['price']?.toString(),
      imageUrl: json['image_url']?.toString(), // Safely convert to string
    );
  }
}

class Category {
  final int? id;
  final String? name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
    );
  }
}
