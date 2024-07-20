import 'package:http/http.dart' as http;
import 'package:freelancing/models/service.dart';
import 'dart:convert';

class ServiceApi {
  final String Url = 'http://localhost:8000/api/services';
  Future<Service> createService(Service service) async {
    final response = await http.post(
      Uri.parse(Url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
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
