import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testeeeer/karamffolder/colors.dart';
// Import your Profile class here

class ClientProfile extends StatefulWidget {
  const ClientProfile({super.key});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  String? name;
  String? email;
  String? personalOverview;
  int? totalProject;
  double? rating;
  int? totalReview;
  String? avatarUrl;
  String? imageBaseUrl;

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token == null) {
      // Handle the case where the token is not available
      return;
    }

    final response = await http.get(
      Uri.parse('http://192.168.137.150:8000/api/my'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final userData = data['data user'];
      final elseData = data['data else'];
      final imageBaseUrl = data['image_url'];

      setState(() {
        name = '${userData['first_name']} ${userData['last_name']}';
        email = userData['email'];
        personalOverview = elseData['personal_overview'] ?? '';
        totalProject = elseData['total_project'] ?? 0;
        rating = elseData['Rating']?.toDouble() ?? 0.0;
        totalReview = elseData['total_review'] ?? 0;
        avatarUrl = '$imageBaseUrl/${userData['avatar']}';
        this.imageBaseUrl = imageBaseUrl;
      });
    } else {
      // Handle error response
      print('Failed to load profile data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
              const Text(
                'Profile',
                textAlign: TextAlign.center,
                //  style: TextStyle(fontSize: 25, color: IndigoDye),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Image.asset(
                  'assets/images/profile.png',
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: avatarUrl != null
                ? Image.network(
                    avatarUrl!,
                    height: 100,
                    width: 100,
                  )
                : Image.asset(
                    'assets/images/profile.png',
                    height: 100,
                    width: 100,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: TextButton(
              onPressed: () {
                // Handle edit profile image
              },
              child: Text(
                'Edit profile image',
                style: TextStyle(color: Aquamarine, fontSize: 15),
              ),
            ),
          ),
          Center(
            child: Text(
              '$name',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          ListTile(
            title: const Text(
              'Email',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text(email ?? ''),
          ),
          ListTile(
            title: const Text(
              'Total Project',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text(totalProject?.toString() ?? '0'),
          ),
          ListTile(
            title: const Text(
              'Rating',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text(rating?.toString() ?? '0.0'),
          ),
          ListTile(
            title: const Text(
              'Total Review',
              style: TextStyle(fontSize: 25),
            ),
            subtitle: Text(totalReview?.toString() ?? '0'),
          ),
        ],
      ),
    );
  }
}
