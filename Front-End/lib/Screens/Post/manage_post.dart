import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/post_provider.dart';
import 'package:freelancing/main.dart';
import 'package:freelancing/Screens/Post/post_management.dart';

class ManagePostsScreen extends ConsumerWidget {
  const ManagePostsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postNotifierProvider);
    void _handleDelete(int index) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.background,
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
                  ref.read(postNotifierProvider.notifier).deletePost(index);
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.background,
        elevation: 0.0,
        toolbarHeight: 70.0,
        title: Text(
          'Manage Posts',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.background, fontSize: 24),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              gradient: LinearGradient(colors: [
                colorScheme.onSecondary,
                colorScheme.onSurface,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        ),
      ),
      body: posts.isEmpty
          ? Center(
              child: Text(
              'No posts available.',
              style: TextStyle(color: colorScheme.primary),
            ))
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Description:',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: post.description,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: colorScheme.onBackground,
                                    )),
                          ]),
                        ),
                        const SizedBox(height: 8),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Budget: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                                text: '\$${post.budget.toStringAsFixed(2)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: colorScheme.onBackground,
                                    )),
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Deadline: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: post.deadline,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: colorScheme.onBackground),
                            )
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Category ID: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: post.category.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: colorScheme.onBackground),
                            )
                          ]),
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: 'Type: ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: colorScheme.onSurface,
                                      fontWeight: FontWeight.bold),
                            ),
                            TextSpan(
                              text: post.type,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: colorScheme.onBackground),
                            )
                          ]),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: colorScheme.onSurface,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostManagement(
                                  editingPost: post,
                                  editingIndex: index,
                                ),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: colorScheme.onSurface,
                          ),
                          onPressed: () {
                            _handleDelete(index);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PostManagement(),
            ),
          );
        },
         backgroundColor: colorScheme.onSecondary,
          child: Icon(Icons.add,color:colorScheme.background,),
      ),
    );
  }
}
