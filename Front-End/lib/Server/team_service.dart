import 'package:freelancing/models/team.dart';
import 'package:freelancing/models/freelancer.dart';
import 'package:freelancing/utils/token.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TeamService {
  static const String baseUrl = 'http://localhost:8000/api';

  static Future<List<Team>> getTeams() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/clients/myteams'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> data = json.decode(response.body);
      return data.map((teamData) => Team.fromJson(teamData)).toList();
    } else {
      print(response.body);
      throw Exception('Failed to load teams');
    }
  }

  static Future<Team> fetchTeamDetails(String teamName) async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/team/myinvitation/$teamName'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> data = json.decode(response.body);
      return Team.fromJson(data);
    } else {
      print(response.body);
      throw Exception('Failed to load team details');
    }
  }

  static Future<Team> createTeam(String name) async {
    final token = await TokenStorage.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/client/teams'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'name': name}),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
      return Team.fromJson(json.decode(response.body));
    } else {
      print(response.body);
      throw Exception('Failed to create team');
    }
  }

  // static Future<void> addFreelancerToTeam(
  //     String teamName, Freelancer freelancer) async {
  //   await http.post(
  //     Uri.parse('$baseUrl/client/teams/requests'),
  //     body: {
  //       'team_name': teamName,
  //       'name': freelancer.name,
  //       'message': 'Hello, welcome to our team if you want',
  //     },
  //   );
  // }
  static Future<void> addFreelancerToTeam(
      String teamName, Freelancer freelancer) async {
    final token = await TokenStorage.getToken();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/client/teams/requests'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'team_name': teamName,
          'name': freelancer.name,
          'message': 'Hello, welcome to our team if you want',
        }),
      );

      // Check if the response indicates success
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Freelancer added successfully');
      } else {
        print(response.body);
        throw Exception(
            'Failed to add freelancer to team. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any errors that occur during the HTTP request
      print('Error adding freelancer to team: $e');
    }
  }

  static Future<void> deleteTeam(String teamName) async {
    final token = await TokenStorage.getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/team/$teamName'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      print(response.statusCode);
    } else {
      print(response.body);
      throw Exception('Failed to delete team');
    }
  }

  static Future<void> deleteFreelancerFromTeam(
      String teamName, Freelancer freelancer) async {
    await http.delete(Uri.parse(
        '$baseUrl/client/teams/$teamName/freelancers/${freelancer.name}')); // Assuming freelancer has an email field
  }
}
