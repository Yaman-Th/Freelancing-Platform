import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/manage_post.dart';
import 'package:freelancing/Provider/post_provider.dart';
import 'package:freelancing/models/post.dart';

class PostManagement extends ConsumerStatefulWidget {
  final Post? editingPost;
  final int? editingIndex;

  const PostManagement({super.key, this.editingPost, this.editingIndex});

  @override
  ConsumerState<PostManagement> createState() => _PostManagementState();
}

class _PostManagementState extends ConsumerState<PostManagement> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _deadlineController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  String? _selectedType;
  final List<String> _types = ['job', 'freelance'];
  int? editingIndex;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.editingPost != null) {
      _titleController.text = widget.editingPost!.title;
      _descriptionController.text = widget.editingPost!.description;
      _selectedType = widget.editingPost!.type;
      _budgetController.text = widget.editingPost!.budget.toString();
      _deadlineController.text = widget.editingPost!.deadline;
      _categoryIdController.text = widget.editingPost!.category.toString();
      editingIndex = widget.editingIndex;
    }
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _budgetController.dispose();
    _categoryIdController.dispose();
    _deadlineController.dispose();
    _titleController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year, now.month, now.day);
    final lastDate = DateTime(now.year + 2, now.month, now.day);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (BuildContext context, child) {
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
            )),
            dialogBackgroundColor: Theme.of(context).colorScheme.background,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _deadlineController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  void _handlePost(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        title: _titleController.text,
        description: _descriptionController.text,
        type: _selectedType!,
        budget: double.parse(_budgetController.text),
        deadline: _deadlineController.text,
        category: int.parse(_categoryIdController.text),
      );

      if (editingIndex != null) {
        ref
            .read(postNotifierProvider.notifier)
            .editPost(widget.editingPost!.id!, newPost);
      } else {
        ref.read(postNotifierProvider.notifier).createPost(newPost);
      }

      setState(() {
        _titleController.clear();
        _descriptionController.clear();
        _typeController.clear();
        _budgetController.clear();
        _deadlineController.clear();
        _categoryIdController.clear();
        editingIndex = null;
      });
    }
  }

  void _navigateToManagePosts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ManagePostsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        title: Text(
          widget.editingIndex != null ? 'Edit Post' : 'Create a Post',
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
          child: Column(
            children: [
              Form(
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
                          maxLines: null,
                          cursorColor: Colors.black,
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
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _budgetController,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
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
                            controller: _deadlineController,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
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
                      'Category ID',
                      style: TextStyle(color: colorScheme.onSurface),
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
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colorScheme.onSurface,
                            width: 2.8,
                          ),
                        ),
                        hintText: 'Ex: 1',
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
                          return 'Please enter a category ID';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Choose your type',
                      style: TextStyle(color: colorScheme.onSurface),
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
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
                        hintText: 'Type',
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
                        )),
                      ),
                      items: _types.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                      dropdownColor: Theme.of(context).colorScheme.onSecondary,
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a type';
                        }
                        return null;
                      },
                      iconEnabledColor: Theme.of(context).colorScheme.onSurface,
                      iconSize: 30,
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          onPressed: () => _handlePost(context),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Text(
                              widget.editingIndex != null
                                  ? 'Update Post'
                                  : 'Post',
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
                    )
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
