import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:testeeeer/karamffolder/colors.dart';
import 'package:testeeeer/karamffolder/email_verfiction.dart';
import 'package:testeeeer/karamffolder/home.dart';

class post extends StatefulWidget {
  const post({super.key});

  @override
  State<post> createState() => _postState();
}

Future _post(String id, String title, String description, String deadline,
    String budget, String type, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  var response = await http.post(
    Uri.parse('http://192.168.137.47:8000/api/posts'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: <String, String>{
      'category_id': id,
      'title': title,
      'description': description,
      'budget': budget,
      'deadline': deadline,
      'type': type,
    },
  );

  if (response.statusCode == 200) {
    var js = jsonDecode(response.body);
    print('yes');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PostsScreen();
        },
      ),
    );
    // String token = js['token'];
    // print('the token is $token');

    // Save the token to shared preferences
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('first_token', token1);

    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) {
    //       return FreelancerEmailVerification();
    //     },
    //   ),
    // );
  } else {
    print('sorry');
  }
}

final TextEditingController _titleController = TextEditingController();
final TextEditingController _idController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _budgetController = TextEditingController();
final TextEditingController _typeController = TextEditingController();
final TextEditingController _dateController = TextEditingController();

class _postState extends State<post> {
  String? selectedType;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Creat a Post'),
      ),
      body: Container(
        child: ListView(
          children: [
            SizedBox(height: 50),
            Center(
              child: Text(
                'Title',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'Title',
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
            Center(
              child: Text(
                'Description',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'Description',
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
            Center(
              child: Text(
                'Budget',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: _budgetController,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'budget',
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
            Center(
              child: Text(
                'Category',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: _idController,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'ID',
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
            Center(
              child: Text(
                'Daed Line',
                style: TextStyle(fontSize: 18),
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
                      _dateController.text =
                          "${pickedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                      focusColor: Silver,
                      hintText: 'dead line',
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
                    type: 'freelance',
                    isSelected: selectedType == 'freelance',
                    onTap: () {
                      setState(() {
                        selectedType = 'freelance';
                      });
                    },
                  ),
                  TypeSelectionButton(
                    type: 'job',
                    isSelected: selectedType == 'job',
                    onTap: () {
                      setState(() {
                        selectedType = 'job';
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
                    _typeController.text = selectedType!;
                  }
                  print(_typeController.text);
                  print(_dateController.text);
                  _post(
                    _idController.text,
                    _titleController.text,
                    _descriptionController.text,
                    _dateController.text,
                    _budgetController.text,
                    _typeController.text,
                    context,
                  );

                  // Navigator.of(context).push(MaterialPageRoute(
                  //     builder: (context) => freelanceremailverifiction()));
                },
                child: Text(
                  'Post',
                  style: TextStyle(fontSize: 20, color: White),
                ),
                backgroundColor: Aquamarine,
              ),
            ),
            SizedBox(height: 8),
            // Text(
            //   'or continue with',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     fontSize: 18,
            //     color: Silver,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 25, right: 25, top: 10),
            //   child: FloatingActionButton(
            //     onPressed: () {},
            //     child: Image.asset(
            //       'assets/images/google.png',
            //       height: 30,
            //       width: 30,
            //     ),
            //     backgroundColor: Silver,
            //   ),
            // ),
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
              type == 'freelance'
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
