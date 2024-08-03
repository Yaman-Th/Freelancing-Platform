import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:freelancing/Server/service.dart';
import 'package:freelancing/models/service.dart';
import 'dart:io';
import 'package:freelancing/widget/image_input.dart';
import 'package:provider/provider.dart';
import 'package:freelancing/Provider/service_provider.dart';

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

void _handleService() {
  if (_formKey.currentState!.validate()) {
    if (_selectedImage == null) {
      // Handle the case where no image is selected
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image'),
        ),
      );
      return;
    }

    final service = Service(
      title: _titleController.text,
      description: _descriptionController.text,
      deliveryDays: int.parse(_deliveryDaysController.text),
      price: double.parse(_priceController.text),
      categoryId: int.parse(_categoryIdController.text),
      image: _selectedImage!.path,
    );

    if (editingIndex != null) {
      Provider.of<ServiceProvider>(context, listen: false)
          .updateService(editingIndex!, service, _selectedImage!);
      editingIndex = null;
    } else {
      Provider.of<ServiceProvider>(context, listen: false)
          .addService(service, _selectedImage!);
    }

    _titleController.clear();
    _descriptionController.clear();
    _deliveryDaysController.clear();
    _priceController.clear();
    _categoryIdController.clear();
    setState(() {
      _selectedImage = null;
    });
  }
}

  void _handleEdit(int index) {
    setState(() {
      editingIndex = index;
      final service = Provider.of<ServiceProvider>(context, listen: false).services[index];
      _titleController.text = service.title;
      _descriptionController.text = service.description;
      _deliveryDaysController.text = service.deliveryDays.toString();
      _priceController.text = service.price.toString();
      _categoryIdController.text = service.categoryId.toString();
      _selectedImage = service.image != null ? File(service.image!) : null;
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
            'Are you sure you want to delete this service?',
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
                Provider.of<ServiceProvider>(context, listen: false)
                    .deleteService(index);
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
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final services = Provider.of<ServiceProvider>(context).services;
    final colorScheme = Theme.of(context).colorScheme;

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
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.onSurface,
                      colorScheme.onSecondary,
                      colorScheme.onPrimary
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
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
                            return 'Please enter delivery days';
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
                      const SizedBox(height: 12),
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
                            return 'Please enter a category ID';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          labelText: 'Selected Image',
                          labelStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          border: InputBorder.none,
                        ),
                        controller: TextEditingController(
                          text: _selectedImage != null ? 'Image Selected' : 'No Image Selected',
                        ),
                        readOnly: true,
                      ),
                      const SizedBox(height: 12),
                      ImageInput(
                        onPickImage: (image) {
                          _selectImage(image);
                        },
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: _handleService,
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Theme.of(context).colorScheme.primary,
                          ),
                          child: Text(
                            editingIndex != null ? 'Update Service' : 'Create Service',
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: services.length,
                itemBuilder: (ctx, index) {
                  final service = services[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: service.image != null
                          ? Image.file(File(service.image!))
                          : const Icon(Icons.image),
                      title: Text(service.title),
                      subtitle: Text(service.description),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _handleEdit(index),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _handleDelete(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
