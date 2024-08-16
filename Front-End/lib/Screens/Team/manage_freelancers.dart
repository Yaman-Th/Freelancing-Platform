import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'package:freelancing/main.dart';
import 'package:freelancing/models/freelancer.dart';
import 'package:freelancing/models/team.dart';

class ManageFreelancersScreen extends ConsumerStatefulWidget {
  final int teamIndex;

  const ManageFreelancersScreen({super.key, required this.teamIndex});

  @override
  ConsumerState<ManageFreelancersScreen> createState() =>
      _ManageFreelancersScreenState();
}

class _ManageFreelancersScreenState
    extends ConsumerState<ManageFreelancersScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _statusController = TextEditingController();

  void _addFreelancer() {
    if (_nameController.text.isNotEmpty && _statusController.text.isNotEmpty) {
      final freelancer = Freelancer(
        id: DateTime.now().millisecondsSinceEpoch, // Generate a unique ID
        name: _nameController.text,
      );

      ref
          .read(teamProvider.notifier)
          .addFreelancerToTeam(widget.teamIndex, freelancer);

      _nameController.clear();
      _statusController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(teamProvider);
    final team = teams[widget.teamIndex];

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40.0,
          title: Text(
            'Manage Freelancers ',
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 20,
                ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Freelancer Name',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  Text(
                    'Enter the freelancer name',
                    style: TextStyle(
                      color: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.7),
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      fillColor: Theme.of(context).colorScheme.secondary,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.onSurface,
                          width: 2.8,
                        ),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a team name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: _addFreelancer,
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        child: Text('Add Freelancer',
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ));
  }
}
