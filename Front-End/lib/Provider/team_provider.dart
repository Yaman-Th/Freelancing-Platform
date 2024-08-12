import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Server/team_service.dart';
import 'package:freelancing/models/team.dart';
import 'package:freelancing/models/freelancer.dart';

final teamProviderNotifier = ChangeNotifierProvider<TeamProvider>((ref) {
  return TeamProvider();
});

class TeamProvider extends ChangeNotifier {
  List<Team> teams = [];
  final TextEditingController teamNameController = TextEditingController();

  TeamProvider() {
    fetchTeams();
  }

  Future<void> fetchTeams() async {
    teams = await TeamService.getTeams();
    notifyListeners();
  }

  Future<void> createTeam() async {
    if (teamNameController.text.isNotEmpty) {
      final newTeam = await TeamService.createTeam(teamNameController.text);
      teams.add(newTeam);
      teamNameController.clear();
      notifyListeners();
    }
  }

  Future<void> deleteTeam(Team team) async {
    await TeamService.deleteTeam(team.name);
    teams.remove(team);
    notifyListeners();
  }

  Future<void> addFreelancerToTeam(Team team, Freelancer freelancer) async {
    await TeamService.addFreelancerToTeam(team.name, freelancer);
    final teamIndex = teams.indexWhere((t) => t.name == team.name);
    if (teamIndex != -1) {
      teams[teamIndex].freelancers.add(freelancer);
      notifyListeners();
    }
  }

  Future<void> deleteFreelancerFromTeam(Team team, Freelancer freelancer) async {
    await TeamService.deleteFreelancerFromTeam(team.name, freelancer);
    final teamIndex = teams.indexWhere((t) => t.name == team.name);
    if (teamIndex != -1) {
      teams[teamIndex].freelancers.remove(freelancer);
      notifyListeners();
    }
  }
}
