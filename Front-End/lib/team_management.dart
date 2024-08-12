import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'team_details.dart';

class TeamManagement extends ConsumerWidget {
  const TeamManagement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Changed watch to ref
    final teamProvider = ref.watch(teamProviderNotifier); // Correctly watch the provider

    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: teamProvider.teamNameController,
              decoration: InputDecoration(
                labelText: 'Team Name',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => teamProvider.teamNameController.clear(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: teamProvider.createTeam,
              child: const Text('Create Team'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: teamProvider.teams.length,
                itemBuilder: (context, index) {
                  final team = teamProvider.teams[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text(team.name),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => teamProvider.deleteTeam(team),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeamDetailScreen(team: team),
                        ),
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
