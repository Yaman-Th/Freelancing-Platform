import 'dart:convert';
import 'package:freelancing/utils/token.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AuthService {
  static const String Url = 'http://localhost:8000/api';

  Future<bool> register(
      String firstName,
      String lastName,
      String type,
      String email,
      String password,
      String passwordConfirmation,
      String birthday) async {
    final response = await http.post(
      Uri.parse('$Url/register'),
      headers: {
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
      Uri.parse('$Url/login'),
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
      await TokenStorage.saveToken(token);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('Login successful. Token: $token');
      return true;
    } else {
      print('Failed to login. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      return false;
    }
  }
    Future<void> logoutUser() async {
    final String apiUrl = '$Url/logout';

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          print('Logout successful');

          // Clear token and other relevant data
          await prefs.remove('token');
          await prefs.setBool('isLoggedIn', false);
        } else {
          print('Logout failed with status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Logout error: $e');
        throw e; // Optionally, you can throw the error to be handled by the caller
      }
    } else {
      print('No token found');
    }
  }
  
}
