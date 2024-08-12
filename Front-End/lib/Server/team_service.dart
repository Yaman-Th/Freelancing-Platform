import 'package:freelancing/models/team.dart';
import 'package:freelancing/models/freelancer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamService {
  static const String baseUrl = 'http://10.65.1.66:8000/api';

  static Future<List<Team>> getTeams() async {
    final response = await http.get(Uri.parse('$baseUrl/clients/myteams'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((teamData) => Team.fromJson(teamData)).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }

  static Future<Team> createTeam(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/client/teams'),
      body: {'name': name},
    );
    if (response.statusCode == 201) {
      return Team.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create team');
    }
  }

  static Future<void> addFreelancerToTeam(String teamName, Freelancer freelancer) async {
    await http.post(
      Uri.parse('$baseUrl/client/teams/requests'),
      body: {
        'team_id': teamName,
        'email': freelancer.name, // Assuming the freelancer has an email field
        'message': 'Hello, welcome to our team',
      },
    );
  }

  static Future<void> deleteTeam(String teamName) async {
    await http.delete(Uri.parse('$baseUrl/client/teams/$teamName'));
  }

  static Future<void> deleteFreelancerFromTeam(String teamName, Freelancer freelancer) async {
    await http.delete(Uri.parse('$baseUrl/client/teams/$teamName/freelancers/${freelancer.name}')); // Assuming freelancer has an email field
  }
}
