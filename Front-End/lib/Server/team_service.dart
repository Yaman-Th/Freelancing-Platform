import 'dart:convert';
import 'package:freelancing/models/freelancer.dart';
import 'package:freelancing/utils/token.dart';
import 'package:http/http.dart' as http;
import 'package:freelancing/models/team.dart';

class TeamService {
  static const String _baseUrl = 'http://192.168.1.6:8000/api/teams';

  Future<List<Team>> fetchTeams() async {
    final token = await TokenStorage.getToken();
    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => Team.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load teams');
    }
  }

  Future<Team> createTeam(Team team) async {
    final token = await TokenStorage.getToken();
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(team.toJson()),
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Team.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create team');
    }
  }

  Future<void> deleteTeam(String teamName) async {
    final token = await TokenStorage.getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$teamName'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete team');
    }
  }

  Future<void> addFreelancerToTeam(String teamName, Freelancer freelancer) async {
    final token = await TokenStorage.getToken();
    final response = await http.post(
      Uri.parse('$_baseUrl/$teamName/freelancers'),
      headers: {
        'Authorization':  'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(freelancer.toJson()),
    );
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add freelancer to team');
    }
  }

  Future<void> deleteFreelancerFromTeam(String teamName, int freelancerId) async {
    final token = await TokenStorage.getToken();
    final response = await http.delete(
      Uri.parse('$_baseUrl/$teamName/freelancers/$freelancerId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode != 204) {
      throw Exception('Failed to delete freelancer from team');
    }
  }
}
