import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freelancing/Server/service.dart';
import 'dart:io';
import 'package:freelancing/widget/image_input.dart';
import 'package:freelancing/main.dart';
import 'package:http/http.dart' as http;

class ServiceManagement extends StatefulWidget {
  const ServiceManagement({super.key});

  @override
  State<ServiceManagement> createState() {
    return _ServiceManagementState();
  }
}

class _ServiceManagementState extends State<ServiceManagement> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deliveryDaysController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryIdController = TextEditingController();
  File? _selectedImage;
  //List<Service> services = [];
  List<Map<String, dynamic>> services = [];
  int? editingIndex;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deliveryDaysController.dispose();
    _priceController.dispose();
    _categoryIdController.dispose();
    super.dispose();
  }

  // Future<Service> createService(Service service) async {
  //   final response = await http.post(
  //     Uri.parse('http://192.168.1.8:8000/api/services'),
  //     headers: {
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(service.toJson()),
  //   );

  //   if (response.statusCode == 201) {
  //     return Service.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to create service');
  //   }
  // }

  // void _createService() async {
  //   Service newService = Service(
  //       title: _titleController.text,
  //       description: _descriptionController.text,
  //       image: _selectedImage!.path,
  //       deliveryDays: _deliveryDaysController.text,
  //       price: double.parse(_priceController.text),
  //       categoryId: 10);

  //   try {
  //     final createdService = await createService(newService);
  //     setState(() {
  //       services.add(createdService);
  //       _titleController.clear();
  //       _descriptionController.clear();
  //       _deliveryDaysController.clear();
  //       _priceController.clear();
  //       _selectedImage = null;
  //     });
  //   } catch (e) {
  //     print('Failed to create service: $e');
  //   }
  // }
  void _handleService() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        final newService = {
          'title': _titleController.text,
          'description': _descriptionController.text,
          'image': _selectedImage,
          'delivery_days': _deliveryDaysController.text,
          'price': _priceController.text,
          'category_id': _categoryIdController.text
        };

        if (editingIndex != null) {
          services[editingIndex!] = newService;
          editingIndex = null;
        } else {
          services.add(newService);
        }

        _titleController.clear();
        _descriptionController.clear();
        _deliveryDaysController.clear();
        _priceController.clear();
        _categoryIdController.clear();
        _selectedImage = null;
      });
    }
  }

  // void _handleEdit(int index) {
  //   setState(() {
  //     editingIndex = index;
  //     final service = services[index];
  //     _titleController.text = service.title;
  //     _descriptionController.text = service.description;
  //     _selectedImage = File(service.image);
  //     _deliveryDaysController.text = service.deliveryDays;
  //     _categoryIdController.text = service.categoryId.toString();
  //     _priceController.text = service.price.toString();
  //   });
  // }
  void _handleEdit(int index) {
    setState(() {
      editingIndex = index;
      final post = services[index];
      _titleController.text = post['title'];
      _descriptionController.text = post['description'];
      _selectedImage = post['image'];
      _deliveryDaysController.text = post['delivery_days'];
      _priceController.text = post['price'];
      _categoryIdController.text = post['category_id'];
    });
  }

  void _handleDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onPrimary,
          title: Text(
            'Confirm Delete',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          content: Text(
            'Are you sure you want to delete this post?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.red,
                    ),
              ),
              onPressed: () {
                setState(() {
                  services.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _selectImage(File pickedImage) {
    _selectedImage = pickedImage;
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _fetchServices();
  // }

  // void _fetchServices() async {
  //   try {
  //     final fetchedServices = await Service.getAllServices();
  //     setState(() {
  //       services = fetchedServices;
  //     });
  //   } catch (e) {
  //     print('Failed to fetch services: $e');
  //   }
  // }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Post Your Service',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient:LinearGradient(colors: [
                    colorScheme.onSurface,
                    colorScheme.onSecondary,
                    colorScheme.onPrimary
                  ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ) ,
                 // color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descriptionController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
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
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _deliveryDaysController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Delivery Days',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a delivery days';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _priceController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a price';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        controller: _categoryIdController,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          border: InputBorder.none,
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a category';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      TextFormField(
                        readOnly: true,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          hintText: 'Image',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          border: InputBorder.none,
                        ),
                      ),
                      ImageInput(
                        onPickImage: (image) {
                          _selectedImage = image;
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: _handleService,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.background,
                          ),
                          child: Text(
                            editingIndex != null ? 'Save' : 'Post',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Your latest services',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 20),
              services.isNotEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: services.length,
                      itemBuilder: (context, index) {
                        final post = services[index];
                        return Card(
                          color: Theme.of(context).colorScheme.onSurface,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Post ${index + 1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium),
                                // Text('Title: ${post.title}'),
                                // Text('Description: ${post.description}'),
                                // Text('Deliver Days: ${post.deliveryDays}'),
                                // Text('price: ${post.price}'),
                                // Text('Category: ${post.categoryId}'),
                                // post.image != null
                                //     ? Image.file(
                                //         File(post.image),
                                Text('Title: ${post['title']}'),
                                Text('Description: ${post['description']}'),
                                Text('Deliver Days: ${post['delivery_days']}'),
                                Text('price: ${post['price']}'),
                                Text('Category ID: ${post['category_id']}'),
                                if (post['image'] != null)
                                Image.file(post['image'], width: 100, height: 100),
                                        // height: 100,
                                        // width: double.infinity,
                                        // fit: BoxFit.cover,
                                      //),
                                    // : Container(),
                                // const SizedBox(height: 12),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _handleEdit(index),
                                      child: Text(
                                        'Edit',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface,
                                            ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .background,
                                      ),
                                      onPressed: () => _handleDelete(index),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Column(
                      children: [
                        Text(
                          'No services yet',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onBackground,
                              ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Icon(
                          Icons.error_sharp,
                          color: colorScheme.onSurface,
                          size: 75,
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
