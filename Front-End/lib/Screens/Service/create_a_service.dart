import 'package:flutter/material.dart';
import 'package:freelancing/constant/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:freelancing/Screens/home.dart';
import 'package:freelancing/Screens/Service/get_service.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _deliveryDaysController = TextEditingController();
  File? image;
  final _piker = ImagePicker();

  Future getImage() async {
    final pickedfile =
        await _piker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedfile != null) {
      image = File(pickedfile.path);
    } else {
      print("no image");
    }
  }

  Future _service(
    String title,
    String description,
    String deliveryDays,
    String price,
    String categoryname,
    File? image, // Accept the image file
    BuildContext context,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://localhost:8000/api/services'));
    request.fields.addAll({
      'title': title,
      'description': description,
      'delivery_dayes': deliveryDays,
      'price': price,
      'category_name': categoryname,
    });
    request.files.add(await http.MultipartFile.fromPath('image', image!.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('DONE');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return GetServiceScreen();
          },
        ),
      );
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Create a Service'),
      ),
      body: Container(
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Center(
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
            const Center(
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
            const Center(
              child: Text(
                'Price',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: _priceController,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'Budget',
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
            const Center(
              child: Text(
                'Category',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: _categoryIdController,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'Name',
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
            const Center(
              child: Text(
                'Delivery Days',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
              child: TextFormField(
                controller: _deliveryDaysController,
                decoration: InputDecoration(
                  focusColor: Silver,
                  hintText: 'Delivery Days',
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
            const SizedBox(height: 10),
            Text(
              'Image',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Silver,
              ),
            ),
            Center(
              child: GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Stack(children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 5, color: Colors.white),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(5, 5),
                          ),
                        ],
                      ),
                      child: image != null
                          ? ClipOval(
                              child: Image.file(
                                image!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : Icon(
                              Icons.image,
                              color: Colors.grey.shade300,
                              size: 80.0,
                            ),
                    ),
                  ])),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: FloatingActionButton(
                onPressed: () {
                  _service(
                    _titleController.text,
                    _descriptionController.text,
                    _deliveryDaysController.text,
                    _priceController.text,
                    _categoryIdController.text,
                    image!,
                    context,
                  );
                },
                backgroundColor: Aquamarine,
                child: const Text(
                  'Post',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
