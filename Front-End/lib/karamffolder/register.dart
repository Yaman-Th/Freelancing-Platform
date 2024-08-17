import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:testeeeer/karamffolder/colors.dart';

import 'package:testeeeer/karamffolder/login1.dart';

class ClientRegister extends StatefulWidget {
  const ClientRegister({super.key});

  @override
  State<ClientRegister> createState() => _ClientRegisterState();
}

Future<void> signup(
  String firstName,
  String lastName,
  String type,
  String email,
  String password,
  String passwordConfirmation,
  String birthdate,
  BuildContext context,
) async {
  try {
    var response = await http.post(
      Uri.parse('http://192.168.210.21:8000/api/register'),
      body: <String, String>{
        'first_name': firstName,
        'last_name': lastName,
        'type': type,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'birthdate': birthdate,
      },
    );

    if (response.statusCode == 200) {
      var js = jsonDecode(response.body);
      String token = js['token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      print('The token is $token');
      _showVerificationDialog(context);
    } else {
      print('Signup failed: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle other status codes
    }
  } catch (e) {
    print('Error occurred during signup: $e');
  }
}

Future<void> verifyEmail(String code, BuildContext context) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token'); // The token might be null

    if (token == null) {
      // Handle the case when token is null
      print('Token is null. User might not be authenticated.');
      // Optionally, show an error message or redirect to login
      return;
    }

    var response = await http.post(
      Uri.parse('http://192.168.210.21:8000/api/verify-email'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'code': code,
      }),
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      var js = jsonDecode(response.body);

      if (js.containsKey('token')) {
        String? newToken = js['token'];

        if (newToken != null) {
          await prefs.setString('token', newToken);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return FreelancerEmailVerification();
          //     },
          //   ),
          // );
        } else {
          print('New token is null, something went wrong.');
          // Handle the error appropriately
        }
      }
    } else {
      print('Verification failed: ${response.statusCode}');
      print('Response body: ${response.body}');
      // Handle verification error
    }
  } catch (e) {
    print('Error occurred during verification: $e');
  }
}

void _showVerificationDialog(BuildContext context) {
  TextEditingController verificationCodeController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Email Verification'),
        content: TextField(
          controller: verificationCodeController,
          decoration: InputDecoration(hintText: 'Enter verification code'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await verifyEmail(verificationCodeController.text, context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            child: Text('Verify'),
          ),
        ],
      );
    },
  );
}

final TextEditingController registerTypeController = TextEditingController();
final TextEditingController registerEmailController = TextEditingController();
final TextEditingController registerPasswordController =
    TextEditingController();
final TextEditingController registerPasswordConfirmationController =
    TextEditingController();
final TextEditingController registerFirstNameController =
    TextEditingController();
final TextEditingController registerLastNameController =
    TextEditingController();
final TextEditingController registerBirthdateController =
    TextEditingController();

class _ClientRegisterState extends State<ClientRegister> {
  String? selectedType;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Image.asset(
                'assets/images/Logo.png',
                height: 100,
                width: 100,
              ),
            ),
            SizedBox(height: 15),
            Text(
              '4WORK',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 40, fontWeight: FontWeight.w500, color: BlueGray),
            ),
            SizedBox(height: 5),
            Text(
              'Create an account',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20, fontWeight: FontWeight.w500, color: IndigoDye),
            ),
            Text(
              'Enter your email to sign up for this app',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w500, color: IndigoDye),
            ),
            SizedBox(height: 15),
            _buildTextField(
              controller: registerFirstNameController,
              hintText: 'First Name',
            ),
            _buildTextField(
              controller: registerLastNameController,
              hintText: 'Last Name',
            ),
            _buildTextField(
              controller: registerEmailController,
              hintText: 'email@domain.com',
            ),
            _buildTextField(
              controller: registerPasswordController,
              hintText: 'Password',
              obscureText: true,
            ),
            _buildTextField(
              controller: registerPasswordConfirmationController,
              hintText: 'Re-enter Password',
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GestureDetector(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != selectedDate) {
                    setState(() {
                      selectedDate = pickedDate;
                      registerBirthdateController.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: registerBirthdateController,
                    decoration: InputDecoration(
                      focusColor: Silver,
                      hintText: 'Birthdate',
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
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Select Type',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Silver,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TypeSelectionButton(
                    type: 'freelancer',
                    isSelected: selectedType == 'freelancer',
                    onTap: () {
                      setState(() {
                        selectedType = 'freelancer';
                      });
                    },
                  ),
                  TypeSelectionButton(
                    type: 'client',
                    isSelected: selectedType == 'client',
                    onTap: () {
                      setState(() {
                        selectedType = 'client';
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ElevatedButton(
                onPressed: () {
                  if (selectedType != null) {
                    registerTypeController.text = selectedType!;
                  }
                  if (_validateInputs()) {
                    signup(
                      registerFirstNameController.text,
                      registerLastNameController.text,
                      registerTypeController.text,
                      registerEmailController.text,
                      registerPasswordController.text,
                      registerPasswordConfirmationController.text,
                      registerBirthdateController.text,
                      context,
                    );
                  }
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, color: White),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Aquamarine),
              ),
            ),
            SizedBox(height: 8),
            Text(
              'or continue with',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Silver,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
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
      ),
    );
  }

  bool _validateInputs() {
    if (registerFirstNameController.text.isEmpty ||
        registerLastNameController.text.isEmpty ||
        registerEmailController.text.isEmpty ||
        registerPasswordController.text.isEmpty ||
        registerPasswordConfirmationController.text.isEmpty ||
        registerBirthdateController.text.isEmpty ||
        selectedType == null) {
      // Show an error message or a toast
      print('Please fill in all fields');
      return false;
    }
    // Additional validation logic can be added here
    return true;
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusColor: Silver,
          hintText: hintText,
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
    );
  }
}

class TypeSelectionButton extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const TypeSelectionButton({
    Key? key,
    required this.type,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              type == 'freelancer'
                  ? Icons.person_outline_outlined
                  : Icons.person,
              color: isSelected ? Colors.white : Colors.grey,
            ),
            SizedBox(height: 5),
            Text(
              type,
              style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
