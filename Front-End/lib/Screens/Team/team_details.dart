import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'package:freelancing/models/team.dart';

class TeamDetailsScreen extends ConsumerStatefulWidget {
  final String teamName;

  const TeamDetailsScreen({
    Key? key,
    required this.teamName, required int teamIndex,
  }) : super(key: key);

  @override
  _TeamDetailsScreenState createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends ConsumerState<TeamDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final teamDetailsAsyncValue = ref.watch(teamDetailsProvider(widget.teamName));

    return Scaffold(
      appBar: AppBar(
        title: Text('Team Details: ${widget.teamName}'),
      ),
      body: teamDetailsAsyncValue.when(
        data: (team) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team: ${team.name}',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                const SizedBox(height: 20),
                if (team.invitations.isEmpty)
                  const Text('No Invitations Available'),
                if (team.invitations.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: team.invitations.length,
                      itemBuilder: (context, index) {
                        final invitation = team.invitations[index].teamInvintion;
                        return Column(
                          children: invitation!.map((inv) {
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(
                                  inv.freelancerName ?? 'Unknown',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                subtitle: Text(
                                  'Status: ${inv.freelancerStatus ?? 'Unknown'}',
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                onTap: () {
                                  // Handle invitation tap
                                },
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) {
          return Center(child: Text('Error: ${error.toString()}'));
        },
      ),
    );
  }
}