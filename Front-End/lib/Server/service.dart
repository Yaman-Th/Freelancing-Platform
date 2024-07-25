import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Service {
  final String title;
  final String description;
  final String image;
  final String deliveryDays;
  final double price;
  final int categoryId;

  Service(
      {required this.title,
      required this.description,
      required this.image,
      required this.deliveryDays,
      required this.price,
      required this.categoryId});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      deliveryDays: json['delivery_days'],
      price: json['price'],
      categoryId: json['category_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'delivery_days': deliveryDays,
      'price': price,
      'category_id': categoryId,
    };
  }  

  static Future<List<Service>> getAllServices() async {
    final url = Uri.parse('http://192.168.1.8:8000/api/services');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Service.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<Service> uploadServiceWithImage(
      Service service, File imageFile) async {
    final url = Uri.parse('http://192.168.1.8:8000/api/services');
    var request = http.MultipartRequest('POST', url);

    request.fields['title'] = service.title;
    request.fields['description'] = service.description;
    request.fields['delivery_days'] = service.deliveryDays;
    request.fields['price'] = service.price.toString();
    request.fields['category_id'] = service.categoryId.toString();
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 201) {
      final responseBody = await response.stream.bytesToString();
      return Service.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('Failed to upload service with image');
    }
  }
   Future<Service> createService(Service service) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.8:8000/api/services'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(service.toJson()),
    );

    if (response.statusCode == 201) {
      return Service.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create service');
    }
  }
}
