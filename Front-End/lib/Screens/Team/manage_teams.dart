import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'package:freelancing/Screens/Team/team_details.dart';
import 'package:freelancing/Screens/Team/team_management.dart';
import 'package:freelancing/models/freelancer.dart';

class ManageTeamsScreen extends ConsumerStatefulWidget {
  const ManageTeamsScreen({super.key});

  @override
  _ManageTeamsScreenState createState() => _ManageTeamsScreenState();
}

class _ManageTeamsScreenState extends ConsumerState<ManageTeamsScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch teams when the screen is opened
    Future.microtask(() => ref.read(teamProvider.notifier).fetchTeams());
  }

  void _handleDelete(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text(
            'Confirm Delete',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          content: Text(
            'Are you sure you want to delete this team?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.background,
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
                ref.read(teamProvider.notifier).deleteTeam(index);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
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

  void _showAddFreelancerDialog(
      BuildContext context, WidgetRef ref, int teamIndex) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text(
            'Add Freelancer',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          content: TextField(
            controller: nameController,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
            decoration: InputDecoration(
              hintText: "Enter Freelancer Name",
              hintStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            cursorColor: Theme.of(context).colorScheme.background,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
              onPressed: () {
                final name = nameController.text;
                if (name.isNotEmpty) {
                  final newFreelancer = Freelancer(
                    id: DateTime.now().millisecondsSinceEpoch, // Unique ID
                    name: name,
                  );

                  // Add the freelancer to the team
                  ref
                      .read(teamProvider.notifier)
                      .addFreelancerToTeam(teamIndex, newFreelancer);

                  Navigator.of(context).pop();

                  // Show confirmation
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Freelancer added successfully')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final teams = ref.watch(teamProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0.0,
        toolbarHeight: 70.0,
        title: Text(
          'Manage Teams',
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
                Theme.of(context).colorScheme.onSecondary,
                Theme.of(context).colorScheme.onSurface,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
        ),
      ),
      body: teams.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
              // child: Text('No teams available.',
              //     style:
              //         TextStyle(color: Theme.of(context).colorScheme.primary)),
            )
          : ListView.builder(
              itemCount: teams.length,
              itemBuilder: (context, index) {
                final team = teams[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TeamDetailsScreen(teamIndex: index,teamName: team.name,),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(team.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface)),
                          const SizedBox(height: 8),
                          // Text('${team.freelancers.length} Freelancers',
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .titleMedium!
                          //         .copyWith(
                          //             color: Theme.of(context)
                          //                 .colorScheme
                          //                 .onSurface)),
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
                                      builder: (context) => TeamManagement(
                                        editingTeam: team,
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
                              IconButton(
                                icon: Icon(Icons.person_add,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface),
                                onPressed: () {
                                  _showAddFreelancerDialog(context, ref, index);
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
                builder: (context) => const TeamManagement(),
              ),
            );
          },
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          child: Icon(
            Icons.add,
            color: Theme.of(context).colorScheme.background,
          ),
        ),
      ),
    );
  }
}
