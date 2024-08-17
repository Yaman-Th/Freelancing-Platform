import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testeeeer/chat/conversation_Screen.dart';
import 'package:testeeeer/karamffolder/colors.dart';
import 'package:testeeeer/karamffolder/create_a_service.dart';
import 'package:testeeeer/karamffolder/create_post.dart';

import 'package:testeeeer/karamffolder/freelancer_orders.dart';
import 'package:testeeeer/karamffolder/get_service.dart';
import 'package:testeeeer/karamffolder/home.dart';
import 'package:testeeeer/karamffolder/my_post.dart';
import 'package:testeeeer/karamffolder/my_service.dart';
import 'package:testeeeer/karamffolder/payment_screen.dart';
import 'package:testeeeer/karamffolder/poost.dart';
import 'package:testeeeer/karamffolder/profile.dart';
import 'package:testeeeer/karamffolder/service_order.dart'; // Ensure this is the correct path to EventFormScreen

Future<void> Login(
  String email,
  String password,
  BuildContext context,
) async {
  var response = await http.post(
    Uri.parse('http://192.168.210.21:8000/api/login'),
    body: <String, String>{
      'email': email,
      'password': password,
    },
  );
  if (response.statusCode == 200) {
    var js = jsonDecode(response.body);
    String token = js['token'];
    print('the token is $token');
    // Save the token in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);

    // Navigate to ClientProfile screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ServiceScreen();
        },
      ),
    );
  } else {
    print('sorry');
  }
}

final loginPasswordController = TextEditingController();
final loginEmailController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Image.asset(
              'assets/images/Logo.png',
              height: 100,
              width: 100,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            '4WORK',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: BlueGray,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome back',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: IndigoDye,
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: TextFormField(
              controller: loginEmailController,
              decoration: InputDecoration(
                focusColor: Silver,
                hintText: 'email@domain.com',
                hintStyle: TextStyle(fontSize: 15, color: Silver),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: BlueGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: BlueGray),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: TextFormField(
              controller: loginPasswordController,
              obscureText: true, // Add this to hide the password
              decoration: InputDecoration(
                focusColor: Silver,
                hintText: 'password',
                hintStyle: TextStyle(fontSize: 15, color: Silver),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: BlueGray),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: BlueGray),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ElevatedButton(
              onPressed: () {
                Login(
                  loginEmailController.text,
                  loginPasswordController.text,
                  context,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Aquamarine,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text(
                'Log in',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'or continue with',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Silver),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: FloatingActionButton(
              onPressed: () {},
              child: Image.asset(
                'assets/images/google.png',
                height: 30,
                width: 30,
              ),
              backgroundColor: Silver,
            ),
          ),
        ],
      ),
    );
  }
}
