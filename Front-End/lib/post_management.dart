import 'package:flutter/material.dart';
import 'package:freelancing/main.dart';

class PostManagement extends StatefulWidget {
  const PostManagement({super.key});

  @override
  State<PostManagement> createState() {
    return PostManagementState();
  }
}

class PostManagementState extends State<PostManagement> {
  final postServiceController = TextEditingController();
  Widget? lastPost;
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
              'Create a Post',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 20,
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
                          hintText: ('Write your post here'),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                color:
                                    Theme.of(context).colorScheme.background,
                              ),
                          border: InputBorder.none,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.background,
                            ),
                            child: Text(
                              'Post',
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
              height: 50,
            ),
            Text(
              'Your latest post',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            lastPost != null
                ? Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      width: 350,
                      height: 200,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onSurface,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25))),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'Last Service',
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
                              height: 60,
                            ),
                            Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () {},
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
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        'Last Service',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.background,
                            ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
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
                  )
          ],
        ),
      ),
    );
  }
}
