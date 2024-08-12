import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:testeeeer/colors.dart';
import 'package:testeeeer/email_verfiction.dart';

class clientRegister extends StatefulWidget {
  const clientRegister({super.key});

  @override
  State<clientRegister> createState() => _clientRegisterState();
}

Future Singup(
  String first_name,
  String last_name,
  String type,
  String email,
  String password,
  String password_confirmation,
  String birthdate,
  BuildContext context,
) async {
  var response = await http.post(
    Uri.parse('http://192.168.2.5:8000/api/register'),
    body: <String, String>{
      'first_name': first_name,
      'last_name': last_name,
      'type': type,
      'email': email,
      'password': password,
      'password_confirmation': password_confirmation,
      'birthdate': birthdate,
    },
  );

  if (response.statusCode == 200) {
    var js = jsonDecode(response.body);
    String token1 = js['token'];
    print('the token is $token1');

    // Save the token to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_token', token1);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return FreelancerEmailVerification();
        },
      ),
    );
  } else {
    print('sorry');
  }
}

final Register_type = TextEditingController();
final RegisterEmail = TextEditingController();
final Register_Password = TextEditingController();
final Register_password_confirmation = TextEditingController();
final Register_first_name = TextEditingController();
final Register_last_name = TextEditingController();
final Register_birthdate = TextEditingController();

class _clientRegisterState extends State<clientRegister> {
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
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: Register_first_name,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'first name',
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
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: Register_last_name,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'last name',
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
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: RegisterEmail,
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
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: Register_Password,
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
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8),
              child: TextFormField(
                controller: Register_password_confirmation,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'Re_password',
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
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
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
                      Register_birthdate.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: Register_birthdate,
                    decoration: InputDecoration(
                      focusColor: Silver,
                      hintText: 'birthdate',
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
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: FloatingActionButton(
                onPressed: () {
                  // Handle sign up with selected gender
                  if (selectedType != null) {
                    Register_type.text = selectedType!;
                  }
                  print(Register_type.text);
                  print(Register_birthdate.text);
                  Singup(
                    Register_first_name.text,
                    Register_last_name.text,
                    Register_type.text,
                    RegisterEmail.text,
                    Register_Password.text,
                    Register_password_confirmation.text,
                    Register_birthdate.text,
                    context,
                  );

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => freelanceremailverifiction()));
                },
                child: Text(
                  'Sign up',
                  style: TextStyle(fontSize: 20, color: White),
                ),
                backgroundColor: Aquamarine,
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
