import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/service_provider.dart';
import 'package:freelancing/main.dart';
import 'package:freelancing/service_management.dart';

class ManageServicesScreen extends ConsumerWidget {
  const ManageServicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final services = ref.watch(serviceProvider);
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
                  ref.read(serviceProvider.notifier).deleteService(index);
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
          'Manage Services',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary, fontSize: 24),
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
      body: services.isEmpty
          ? Center(
              child: Text('No services available.',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary)))
          : ListView.builder(
              itemCount: services.length,
              itemBuilder: (context, index) {
                final service = services[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(service.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: colorScheme.onSurface)),
                          const SizedBox(height: 8),
                          Text(
                            service.description,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Price: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                  text: '\$${service.price.toStringAsFixed(2)}',
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
                                text: 'Delivery Days: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: service.deliveryDays.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: colorScheme.onBackground),
                              )
                            ]),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: 'Category_Id: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: service.categoryId.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: colorScheme.onBackground),
                              )
                            ]),
                          ),
                          const SizedBox(height: 12),
                          service.image.isNotEmpty
                              ? Image.file(
                                  File(service.image),
                                  width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 150,
                                  color: Colors.grey[300],
                                  child: const Icon(Icons.image_not_supported,
                                      size:
                                          60), // Placeholder if no image is available
                                ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ServiceManagement(
                                        editingService: service,
                                        editingIndex: index,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                onPressed: () {
                                  _handleDelete(index);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: Align(
        alignment: const Alignment(-0.75, 1),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const ServiceManagement(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
