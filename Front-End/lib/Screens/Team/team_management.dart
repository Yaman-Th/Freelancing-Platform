import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Provider/team_provider.dart';
import 'package:freelancing/models/team.dart';
import 'package:freelancing/Screens/Team/manage_teams.dart';

class TeamManagement extends ConsumerStatefulWidget {
  final Team? editingTeam;
  final int? editingIndex;

  const TeamManagement({super.key, this.editingTeam, this.editingIndex});

  @override
  ConsumerState<TeamManagement> createState() => _TeamManagementState();
}

class _TeamManagementState extends ConsumerState<TeamManagement> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editingTeam != null) {
      _nameController.text = widget.editingTeam!.name;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _handleTeam() {
    if (_formKey.currentState!.validate()) {
      final team = Team(
        name: _nameController.text, freelancers: [], invitations: [],
      );

      if (widget.editingIndex != null) {
        ref.read(teamProvider.notifier).updateTeam(
              widget.editingIndex!,
              team,
            );
      } else {
        ref.read(teamProvider.notifier).addTeam(team.name);
      }

      setState(() {
        _nameController.clear();
      });
    }
  }

  void _navigateToManageTeams(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ManageTeamsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40.0,
        title: Text(
          widget.editingTeam != null ? 'Edit Team' : 'Create Team',
          style: Theme.of(context).textTheme.headline6!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 20,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.manage_search,
              size: 30,
            ),
            onPressed: () => _navigateToManageTeams(context),
          ),
        ],
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
                  'Team Name',
                  style: TextStyle(color: colorScheme.onSurface),
                ),
                Text(
                  'Enter the team name',
                  style: TextStyle(
                    color: colorScheme.primary.withOpacity(0.7),
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
                    fillColor: colorScheme.secondary,
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: colorScheme.onSurface,
                        width: 2.8,
                      ),
                    ),
                    hintText: 'Ex: Development Team',
                    hintStyle:
                        Theme.of(context).textTheme.titleMedium!.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(0.4),
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
                      onPressed: _handleTeam,
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text(
                          widget.editingTeam != null
                              ? 'Update Team'
                              : 'Create Team',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.background,
                                  fontSize: 24)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
