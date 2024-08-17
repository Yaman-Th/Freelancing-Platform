import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key});

  @override
  _EventFormScreenState createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedType;
  String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('token');
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _submitPost(String title, String description, String budget,
      DateTime? deadline, String? type) async {
    if (_token == null) {
      print('Token not available');
      return;
    }

    final response = await http.post(
      Uri.parse('http://192.168.210.21:8000/api/posts'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_token',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
        'budget': budget,
        'deadline': deadline,
        'type': type,
      }),
    );

    if (response.statusCode == 200) {
      print('Post created successfully');
      // Handle successful post creation
    } else {
      print('Failed to create post');
      // Handle error response
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Create Post'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text('Title'),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Add Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            const Text('Description'),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                hintText: 'Add Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: _selectedDate == null
                              ? 'Dead Line'
                              : '${_selectedDate!.toLocal()}'.split(' ')[0],
                          border: const OutlineInputBorder(),
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _budgetController,
                    keyboardType: TextInputType.numberWithOptions(),
                    decoration: const InputDecoration(
                      hintText: 'Budget',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.monetization_on_outlined),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text('Type'),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              items: <String>['job', 'freelance']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedType = newValue;
                });
              },
              hint: const Text('Select Type'),
            ),
            const SizedBox(height: 16),
            FloatingActionButton(
              onPressed: () {
                print('$_selectedDate');
                print('$_selectedType');

                _submitPost(
                  _titleController.text,
                  _descriptionController.text,
                  _budgetController.text,
                  _selectedDate,
                  _selectedType,
                );
              },
              child: const Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
