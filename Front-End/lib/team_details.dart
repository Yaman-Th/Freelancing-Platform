import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'models/team.dart';
import 'models/freelancer.dart';

class TeamDetailScreen extends ConsumerWidget {
  final Team team;
  final TextEditingController freelancerNameController = TextEditingController();

  TeamDetailScreen({super.key, required this.team});
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(team.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: freelancerNameController,
              decoration: const InputDecoration(
                labelText: 'Freelancer Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                final freelancerName = freelancerNameController.text;
                if (freelancerName.isNotEmpty) {
                  ref.read(teamProviderNotifier.notifier).addFreelancerToTeam(
                    team,
                    Freelancer(name: freelancerName, id: 1, status: 'online'),
                  );
                  freelancerNameController.clear();
                }
              },
              child: const Text('Add Freelancer'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: team.freelancers.length,
                itemBuilder: (context, index) {
                  final freelancer = team.freelancers[index];
                  return Card(
                    child: ListTile(
                      title: Text(freelancer.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          ref.read(teamProviderNotifier.notifier).deleteFreelancerFromTeam(team, freelancer);
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
