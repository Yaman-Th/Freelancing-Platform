import 'package:flutter/material.dart';
import 'package:freelancing/Screens/Post/post_screen.dart';
import 'package:freelancing/constant/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:freelancing/Screens/email_verfiction.dart';
import 'package:freelancing/Screens/home.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

Future _post(String id, String title, String description, String deadline,
    String budget, String type, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  var response = await http.post(
    Uri.parse('http://localhost:8000/api/posts'),
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return PostsScreen();
        },
      ),
    );
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

class _PostScreenState extends State<PostScreen> {
  String? selectedType;
  DateTime? selectedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        title: Text(
          'Create a Post',
          style: Theme.of(context).textTheme.headline6!.copyWith(
            color: colorScheme.primary,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.manage_search,
              size: 30,
              color: colorScheme.primary,
            ),
            onPressed: () {
              // Navigate to manage posts
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project title',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                Text(
                  'Make your title clean and short',
                  style: TextStyle(
                    color: colorScheme.primary.withOpacity(0.7),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _titleController,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    fillColor: colorScheme.secondary,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: colorScheme.onSurface,
                        width: 2.8,
                      ),
                    ),
                    hintText: 'Ex: Flutter Front-End',
                    hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.4),
                    ),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                Text(
                  'Description',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                Text(
                  'Brief your description clearly',
                  style: TextStyle(
                    color: colorScheme.primary.withOpacity(0.7),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: colorScheme.secondary,
                    border: Border.all(
                      color: colorScheme.onSurface,
                      width: 2.8,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: TextFormField(
                      controller: _descriptionController,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      maxLines: null,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Description',
                        hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.4),
                        ),
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Delivery Days & Price',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                Text(
                  'Delivery days & price by your service',
                  style: TextStyle(
                    color: colorScheme.primary.withOpacity(0.7),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _budgetController,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          fillColor: colorScheme.secondary,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: colorScheme.onSurface,
                              width: 2.8,
                            ),
                          ),
                          hintText: 'Budget',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.4),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.attach_money_outlined,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a budget';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: TextFormField(
                        controller: _dateController,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        cursorColor: Colors.white,
                        readOnly: true,
                        decoration: InputDecoration(
                          fillColor: colorScheme.secondary,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: colorScheme.onSurface,
                              width: 2.8,
                            ),
                          ),
                          hintText: 'Deadline',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onBackground
                                .withOpacity(0.4),
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          suffixIcon: Icon(
                            Icons.date_range_outlined,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            _dateController.text =
                            "${pickedDate.year}-${pickedDate.month}-${pickedDate.day}";
                          }
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a deadline';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _post(
                          _idController.text,
                          _titleController.text,
                          _descriptionController.text,
                          _dateController.text,
                          _budgetController.text,
                          _typeController.text,
                          context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.background,
                    ),
                    child: const Text('Post'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
