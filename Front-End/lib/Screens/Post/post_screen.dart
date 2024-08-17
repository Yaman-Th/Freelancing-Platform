import 'package:flutter/material.dart';
import 'package:freelancing/Screens/Post/my_post.dart';
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

Future _post(String categoryName, String title, String description, String deadline,
    String budget, String type, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  var response = await http.post(
    Uri.parse('http://localhost:8000/api/posts'),
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: <String, String>{
      'categoryName': categoryName,
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
          return HomeScreen();
        },
      ),
    );
  } else {
    print(response.body);
    print('sorry');
  }
}

final TextEditingController _titleController = TextEditingController();
final TextEditingController _categoryController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();
final TextEditingController _budgetController = TextEditingController();
final TextEditingController _typeController = TextEditingController();
final TextEditingController _dateController = TextEditingController();

class _PostScreenState extends State<PostScreen> {
  String? selectedType;
  DateTime? selectedDate;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _navigateToManagePosts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const myPost()),
    );
  }

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
            onPressed: () => _navigateToManagePosts(context),
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
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        hintStyle:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
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
                          hintStyle:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
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
                          hintStyle:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
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
                          final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData().copyWith(
              colorScheme: ColorScheme.light(
                primary: Theme.of(context).colorScheme.onSecondary,
                onPrimary: Theme.of(context).colorScheme.background,
                surface: Theme.of(context).colorScheme.onSurface,
                onSurface: Theme.of(context).colorScheme.background,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
              ),
              dialogBackgroundColor: Theme.of(context).colorScheme.background,
            ),
            child: child!,
          );
        },
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
                const SizedBox(height: 15),
                Text(
                  'Category',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _categoryController,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    fillColor: colorScheme.secondary,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: colorScheme.onSurface,
                        width: 2.8,
                      ),
                    ),
                    hintText: 'Ex:Programming',
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
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
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // "Select Type" Section
                Text(
                  'Select Type',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
                          _categoryController.text,
                          _titleController.text,
                          _descriptionController.text,
                          _dateController.text,
                          _budgetController.text,
                          selectedType ?? '',
                          context,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: colorScheme.background,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: Text('Post', style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),),
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

// Reusable TypeSelectionButton Widget
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
          color: isSelected
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.onSurface
                : Theme.of(context).colorScheme.onSurface,
            width: 2.0,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
