import 'dart:io';
import 'package:freelancing/utils/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:freelancing/models/service.dart';

class ServiceService {
  static const String _baseUrl = 'http://10.65.1.66:8000/api/services';
  Future<List<Service>> getAllServices() async {
    final url = Uri.parse(_baseUrl);
    final token = await TokenStorage.getToken();
    final response = await http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Service.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load services');
    }
  }

  Future<Service> uploadServiceWithImage(
      Service service, File imageFile) async {
    final url = Uri.parse(_baseUrl);
    final token = await TokenStorage.getToken();
    var request = http.MultipartRequest('POST', url);
    request.headers['Authorization'] ='Bearer $token';
    request.fields['title'] = service.title;
    request.fields['description'] = service.description;
    request.fields['delivery_days'] = service.deliveryDays.toString();
    request.fields['price'] = service.price.toString();
    request.fields['category_id'] = service.categoryId.toString();
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    final response = await request.send();

    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return Service.fromJson(jsonDecode(responseBody));
    } else {
      throw Exception('Failed to upload service with image');
    }
  }

  Future<Service> createService(Service service) async {
    final token = await TokenStorage.getToken();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
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
