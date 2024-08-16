import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelancing/Server/team_service.dart';
import 'package:freelancing/models/team.dart';
import 'package:freelancing/models/freelancer.dart';

// TeamNotifier and teamProvider
final teamProvider = StateNotifierProvider<TeamNotifier, List<Team>>((ref) {
  return TeamNotifier();
});
final teamDetailsProvider = FutureProvider.family<Team, String>((ref, teamName) async {
  return await TeamService.fetchTeamDetails(teamName);
});
class TeamNotifier extends StateNotifier<List<Team>> {
  TeamNotifier() : super([]);

  // Fetch all teams from the backend
  Future<void> fetchTeams() async {
    try {
      List<Team> teams = await TeamService.getTeams();
      state = teams;
    } catch (e) {
      // Handle error
      print('Error fetching teams: $e');
    }
  }
  Future<List<Team>> fetchInvitationTeams(String teamName) async {
    try {
      Team? team = await TeamService.fetchTeamDetails(teamName);
      if (team != null) {
        state = [team];
      } else {
        state = []; // Or handle it differently based on your logic
      }
      return state;
    } catch (e) {
      print('Error fetching teams: $e');
      throw e;
    }
  }



  // Add a new team using the backend service
  Future<void> addTeam(String name) async {
    try {
      Team newTeam = await TeamService.createTeam(name);
      state = [...state, newTeam];
    } catch (e) {
      // Handle error
      print('Error adding team: $e');
    }
  }

  // Update an existing team
  Future<void> updateTeam(int index, Team updatedTeam) async {
    try {
      // You might want to add an update method in the backend
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updatedTeam else state[i],
      ];
    } catch (e) {
      // Handle error
      print('Error updating team: $e');
    }
  }

  // Delete a team using the backend service
  Future<void> deleteTeam(int index) async {
    try {
      String teamName = state[index].name;
      await TeamService.deleteTeam(teamName);
      state = [
        for (int i = 0; i < state.length; i++)
          if (i != index) state[i],
      ];
    } catch (e) {
      // Handle error
      print('Error deleting team: $e');
    }
  }

  // Add a freelancer to a specific team using the backend service
  Future<void> addFreelancerToTeam(int teamIndex, Freelancer freelancer) async {
    try {
      // Get the team name based on the team index
      String teamName = state[teamIndex].name;

      // Send the request to add the freelancer to the team via the backend
      await TeamService.addFreelancerToTeam(teamName, freelancer);

      // Once successful, update the local state
      final updatedTeam = state[teamIndex];
      updatedTeam.freelancers = [...updatedTeam.freelancers, freelancer];

      // Update the state to reflect the new freelancer added
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == teamIndex) updatedTeam else state[i],
      ];
    } catch (e) {
      // Handle error and print it
      print('Error adding freelancer to team: $e');
    }
  }

  // Remove a freelancer from a specific team using the backend service
  Future<void> removeFreelancerFromTeam(
      int teamIndex, int freelancerIndex) async {
    try {
      String teamName = state[teamIndex].name;
      Freelancer freelancer = state[teamIndex].freelancers[freelancerIndex];
      await TeamService.deleteFreelancerFromTeam(teamName, freelancer);

      final updatedTeam = state[teamIndex];
      updatedTeam.freelancers = [
        for (int i = 0; i < updatedTeam.freelancers.length; i++)
          if (i != freelancerIndex) updatedTeam.freelancers[i],
      ];

      state = [
        for (int i = 0; i < state.length; i++)
          if (i == teamIndex) updatedTeam else state[i],
      ];
    } catch (e) {
      // Handle error
      print('Error removing freelancer from team: $e');
    }
  }
}
