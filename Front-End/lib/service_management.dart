import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/service_provider.dart';
import 'package:freelancing/models/service.dart';
import 'package:freelancing/widget/image_input.dart';
import 'package:freelancing/manage_service.dart';

class ServiceManagement extends ConsumerStatefulWidget {
  final Service? editingService;
  final int? editingIndex;

  const ServiceManagement({super.key, this.editingService, this.editingIndex});

  @override
  ConsumerState<ServiceManagement> createState() => _ServiceManagementState();
}

class _ServiceManagementState extends ConsumerState<ServiceManagement> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _deliveryDaysController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryIdController = TextEditingController();
  File? _selectedImage;
  int? editingIndex;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.editingService != null) {
      _titleController.text = widget.editingService!.title;
      _descriptionController.text = widget.editingService!.description;
      _deliveryDaysController.text =
          widget.editingService!.deliveryDays.toString();
      _priceController.text = widget.editingService!.price.toString();
      _categoryIdController.text = widget.editingService!.categoryId.toString();
      _selectedImage = File(widget.editingService!.image);
    }
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _deliveryDaysController.dispose();
    _priceController.dispose();
    _categoryIdController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleService() {
    if (_formKey.currentState!.validate()) {
      if (_selectedImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an image')),
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

      if (widget.editingIndex != null) {
        ref.read(serviceProvider.notifier).updateService(
              widget.editingIndex!,
              service,
            );
      } else {
        ref.read(serviceProvider.notifier).addService(service);
      }

      setState(() {
        _titleController.clear();
        _descriptionController.clear();
        _categoryIdController.clear();
        _deliveryDaysController.clear();
        _priceController.clear();
        _selectedImage = null;
        editingIndex = null;
      });
    }
  }
  
  void _selectImage(File pickedImage) {
    setState(() {
      _selectedImage = pickedImage;
    });
  }

  void _navigateToManageService(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ManageServicesScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        title: Text(
          widget.editingService != null ? 'Edit Service' : 'Create Service',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.manage_search,
              size: 30,
            ),
            onPressed: () => _navigateToManageService(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Form(
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
                        hintText: 'Ex: Graphic Design Service',
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
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                          cursorColor: Colors.black,
                          maxLines: null,
                          decoration: InputDecoration(
                            hintText: 'Description',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
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
                                .copyWith(
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
                              hintText: 'Delivery Days',
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
                                Icons.calendar_today,
                                color: Theme.of(context).colorScheme.onSurface,
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
                                .copyWith(
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
                              hintText: 'Price',
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
                                return 'Please enter the price';
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
                    const SizedBox(height: 10),
                    Text(
                      'Service Category',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                    Text(
                      'Choose the most appropriate category',
                      style: TextStyle(
                        color: colorScheme.primary.withOpacity(0.7),
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _categoryIdController,
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
                        hintText: 'Category ID',
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
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the category ID';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Select an image',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                    Text(
                      'Choose the most appropriate image',
                      style: TextStyle(
                        color: colorScheme.primary.withOpacity(0.7),
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      color: colorScheme.secondary,
                      child: ImageInput(
                        onPickImage: (image) {
                          _selectedImage = image;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _handleService,
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                              widget.editingService != null
                                  ? 'Update Service'
                                  : 'Create Service',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                      fontSize: 24)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
