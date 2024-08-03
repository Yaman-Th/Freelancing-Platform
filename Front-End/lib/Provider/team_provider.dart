import 'package:flutter/material.dart';
import 'package:freelancing/Server/team_service.dart';
import 'package:freelancing/models/freelancer.dart';
import 'package:freelancing/models/team.dart';

class TeamProvider with ChangeNotifier {
  final TeamService _teamService;
  List<Team> _teams = [];

  TeamProvider(this._teamService);

  List<Team> get teams => _teams;

  Future<void> fetchTeams() async {
    _teams = await _teamService.fetchTeams();
    notifyListeners();
  }

  Future<void> createTeam(Team team) async {
    final newTeam = await _teamService.createTeam(team);
    _teams.add(newTeam);
    notifyListeners();
  }

  Future<void> deleteTeam(String teamName) async {
    await _teamService.deleteTeam(teamName);
    _teams.removeWhere((team) => team.name == teamName);
    notifyListeners();
  }

  Future<void> addFreelancerToTeam(String teamName, Freelancer freelancer) async {
    await _teamService.addFreelancerToTeam(teamName, freelancer);
    final team = _teams.firstWhere((team) => team.name == teamName);
    team.freelancers.add(freelancer);
    notifyListeners();
  }

  Future<void> deleteFreelancerFromTeam(String teamName, int freelancerId) async {
    await _teamService.deleteFreelancerFromTeam(teamName, freelancerId);
    final team = _teams.firstWhere((team) => team.name == teamName);
    team.freelancers.removeWhere((freelancer) => freelancer.id == freelancerId);
    notifyListeners();
  }
}
