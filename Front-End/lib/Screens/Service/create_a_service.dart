import 'package:flutter/material.dart';
import 'package:freelancing/Screens/Service/my_service.dart';
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
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _deliveryDaysController = TextEditingController();
  File? image;
  final _picker = ImagePicker();
  final FocusNode _focusNode = FocusNode();

  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    } else {
      print("No image selected");
    }
  }

  Future _service(
    String title,
    String description,
    String deliveryDays,
    String price,
    String categoryId,
    File? image, 
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
      'category_name': categoryId,
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
   void _navigateToManageServices(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  getMyServiceScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Service'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.manage_search, size: 30),
            onPressed: () =>_navigateToManageServices,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Service Title',
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
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: colorScheme.primary),
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
                  hintText: 'Ex: Graphic Design Service',
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.4),
                      ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                'Brief your description clear',
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
                    color: _focusNode.hasFocus
                        ? colorScheme.onSurface
                        : colorScheme.primary,
                    width: _focusNode.hasFocus ? 2.8 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    focusNode: _focusNode,
                    controller: _descriptionController,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: colorScheme.primary),
                    cursorColor: Colors.black,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Description',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                            color: colorScheme.onBackground.withOpacity(0.4),
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
              const SizedBox(height: 12),
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
                      controller: _deliveryDaysController,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: colorScheme.primary),
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
                        hintText: 'Delivery Days',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: colorScheme.onBackground.withOpacity(0.4),
                            ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: Icon(
                          Icons.calendar_today,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the number of delivery days';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: _priceController,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: colorScheme.primary),
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
                        hintText: 'Price',
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: colorScheme.onBackground.withOpacity(0.4),
                            ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        suffixIcon: Icon(
                          Icons.attach_money_outlined,
                          color: colorScheme.onSurface,
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid price';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Category ID',
                style: TextStyle(color: colorScheme.onSurface),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _categoryIdController,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: colorScheme.primary),
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
                  hintText: 'Enter Category ID',
                  hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: colorScheme.onBackground.withOpacity(0.4),
                      ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category ID';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Upload Image',
                style: TextStyle(
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                icon: const Icon(Icons.add_photo_alternate, size: 24),
                label: Text(
                  'Upload',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorScheme.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                ),
                onPressed: getImage,
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _service(
                        _titleController.text,
                        _descriptionController.text,
                        _deliveryDaysController.text,
                        _priceController.text,
                        _categoryIdController.text,
                        image,
                        context,
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32.0, vertical: 16.0),
                    backgroundColor: colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Submit',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
