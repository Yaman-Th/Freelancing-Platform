import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String Url = 'http://192.168.1.8:8000/api/register';

  Future<bool> register(
      String firstName,
      String lastName,
      String type,
      String email,
      String password,
      String passwordConfirmation,
      String birthday) async {
    final response = await http.post(
      Uri.parse(Url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'first_name': firstName,
        'last_name': lastName,
        'type': type,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'birthdate': birthday
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('User registered successfully');
      return true;
    } else {
      print('Failed to register user. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.8:8000/api/login'),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseBody = json.decode(response.body);
      final token = responseBody['token'];
      print('Login successful. Token: $token');
      return true;
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }
}
