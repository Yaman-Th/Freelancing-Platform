import 'package:flutter/material.dart';
import 'package:freelancing/models/freelancer.dart';
import 'package:provider/provider.dart';
import 'package:freelancing/models/team.dart';
import 'package:freelancing/provider/team_provider.dart';

class TeamManagement extends StatefulWidget {
  const TeamManagement({super.key});

  @override
  State<TeamManagement> createState() {
    return TeamManagementState();
  }
}

class TeamManagementState extends State<TeamManagement> {
  final teamNameController = TextEditingController();
  final freelancerNameController = TextEditingController();
  List<Team> teams = [];

  void createTeam() {
    String teamName = teamNameController.text;
    if (teamName.isNotEmpty) {
      setState(() {
        teams.add(Team(name: teamName, freelancers: []));
        teamNameController.clear();
      });
    }
  }

  void addFreelancerToTeam(String teamName) {
    String freelancerName = freelancerNameController.text;
    if (freelancerName.isNotEmpty) {
      setState(() {
        Team? team = teams.firstWhere(
          (team) => team.name == teamName,
          orElse: () => Team(name: '', freelancers: []),
        );
        if (team.name.isNotEmpty) {
          team.freelancers.add(Freelancer(
            id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
            name: freelancerName,
            status: 'pending',
          ));
          freelancerNameController.clear();
        }
      });
    }
  }

  void deleteFreelancerFromTeam(String teamName, int freelancerIndex) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text(
            'Delete Freelancer',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          content: Text(
            'Are you sure you want to delete this freelancer?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  Team? team = teams.firstWhere(
                    (team) => team.name == teamName,
                    orElse: () => Team(name: '', freelancers: []),
                  );
                  if (team.name.isNotEmpty) {
                    team.freelancers.removeAt(freelancerIndex);
                  }
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.red,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deleteTeam(String teamName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text(
            'Delete Team',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          content: Text(
            'Are you sure you want to delete the team "$teamName"?',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  teams.removeWhere((team) => team.name == teamName);
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'Delete',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.red,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showAddFreelancerDialog(String teamName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          title: Text(
            'Add Freelancer',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.background,
                ),
          ),
          content: TextField(
            controller: freelancerNameController,
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
          actions: [
            TextButton(
              onPressed: () {
                addFreelancerToTeam(teamName);
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.background,
                    ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Create your own team',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSurface,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    controller: teamNameController,
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: ('Enter your Team Name'),
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: TextField(
                    controller: freelancerNameController,
                    cursorColor: Theme.of(context).colorScheme.background,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.add,
                            color: Theme.of(context).colorScheme.background),
                        onPressed: () {
                          if (teams.isNotEmpty) {
                            addFreelancerToTeam(teams.last.name);
                          }
                        },
                      ),
                      hintText: ('Freelancer Name'),
                      hintStyle:
                          Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Theme.of(context).colorScheme.background,
                              ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                height: 60,
                width: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: ElevatedButton(
                  onPressed: createTeam,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Create',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.background,
                        ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                child: Text('Team names',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
              ),
              const SizedBox(
                height: 20,
              ),
              ...teams.map((team) => buildTeam(team)).toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTeam(Team team) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              team.name.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            const Spacer(),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    showAddFreelancerDialog(team.name);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteTeam(team.name);
                  },
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        ...team.freelancers.asMap().entries.map((entry) {
          int index = entry.key + 1;
          Freelancer freelancer = entry.value;
          return ListTile(
            leading: Text(
              '$index',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            title: Text(
              freelancer.name,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  freelancer.status,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: freelancer.status == 'accept'
                            ? Colors.green
                            : Colors.orange,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    deleteFreelancerFromTeam(team.name, index - 1);
                  },
                ),
              ],
            ),
          );
        }).toList(),
        const SizedBox(height: 20),
      ],
    );
  }
}
