import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String Url = 'http://localhost:8000/api/register';

  Future<void> register(String firstName,String lastName,String type, String email ,String password, String passwordConfirmation,String birthday) async {
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
        'birthdate':birthday
        
      }),
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
    } else {
      print('Failed to register user');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$Url/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final token = responseBody['token'];
      print('Login successful. Token: $token');
    } else {
      print('Failed to login');
    }
  }
}
