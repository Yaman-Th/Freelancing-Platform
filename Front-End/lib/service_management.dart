import 'package:flutter/material.dart';
import 'package:freelancing/main.dart';

class ServiceManagement extends StatefulWidget {
  const ServiceManagement({super.key});

  @override
  State<ServiceManagement> createState() {
    return ServiceManagementState();
  }
}

class ServiceManagementState extends State<ServiceManagement> {
  final postServiceController = TextEditingController();
  List<String> posts = [];
  int? editingIndex;

  void _handlePost() {
    setState(() {
      if (editingIndex != null) {
        posts[editingIndex!] = postServiceController.text;
        editingIndex = null;
      } else {
        posts.add(postServiceController.text);
      }
      postServiceController.clear();
    });
  }

  void _handleEdit(int index) {
    setState(() {
      editingIndex = index;
      postServiceController.text = posts[index];
    });
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              'Post Your Service',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 10,
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onSecondary,
                    borderRadius: const BorderRadius.all(Radius.circular(25))),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                        cursorColor: Colors.white,
                        controller: postServiceController,
                        decoration: InputDecoration(
                          hintText: ('Write your service here'),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: _handlePost,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.background,
                            ),
                            child: Text(
                              editingIndex != null ? 'Save' : 'Post',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                            ),
                          ),
                          const SizedBox(
                            width: 170,
                          ),
                          Expanded(
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.photo_album_outlined,
                                color: colorScheme.background,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Your latest posts',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            posts.isNotEmpty
                ? Column(
                    children: posts.map((post) {
                      int index = posts.indexOf(post);
                      return Center(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          width: 350,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Post ${index + 1}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                post,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .background,
                                    ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                    onPressed: () => _handleEdit(index),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: colorScheme.background,
                                    ),
                                    child: Text(
                                      'Edit',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface,
                                          ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 170,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.info,
                                      color: colorScheme.background,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                : Column(
                    children: [
                      Text(
                        'No posts yet',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
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
    );
  }
}
