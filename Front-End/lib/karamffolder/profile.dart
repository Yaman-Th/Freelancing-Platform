import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testeeeer/colors.dart';
// Import your Profile class here

class ClientProfile extends StatefulWidget {
  const ClientProfile({super.key});

  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  Profile? _profile;

  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  Future<void> _fetchProfile() async {
    // Retrieve the token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    if (token != null) {
      final response = await http.get(
        Uri.parse('http://192.168.2.5:8000/api/client/myprofile'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _profile = Profile.fromJson(data);
        });
      } else {
        // Handle error
        print('Failed to load profile');
      }
    } else {
      // Handle the case when the token is not found
      print('Token not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profile == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
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
                  child: Image.asset(
                    'assets/images/profile.png',
                    height: 100,
                    width: 100,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 100, right: 100),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit profile image',
                      style: TextStyle(color: Aquamarine, fontSize: 15),
                    ),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Personal Overview',
                    style: TextStyle(fontSize: 25),
                  ),
                  subtitle: Text(_profile!.personalOverview ?? 'N/A'),
                ),
                ListTile(
                  title: const Text(
                    'Total Project',
                    style: TextStyle(fontSize: 25),
                  ),
                  subtitle: Text('${_profile!.totalProject ?? 0}'),
                ),
                ListTile(
                  title: const Text(
                    'Rating',
                    style: TextStyle(fontSize: 25),
                  ),
                  subtitle: Text('${_profile!.rating ?? 0}'),
                ),
                ListTile(
                  title: const Text(
                    'Total Review',
                    style: TextStyle(fontSize: 25),
                  ),
                  subtitle: Text('${_profile!.totalReview ?? 0}'),
                ),
              ],
            ),
    );
  }
}

class Profile {
  int? id;
  int? userId;
  String? personalOverview;
  String? personalImage;
  int? wallet;
  int? isAvailable;
  int? totalProject;
  int? rating;
  int? totalSpend;
  int? totalReview;
  String? createdAt;
  String? updatedAt;

  Profile({
    this.id,
    this.userId,
    this.personalOverview,
    this.personalImage,
    this.wallet,
    this.isAvailable,
    this.totalProject,
    this.rating,
    this.totalSpend,
    this.totalReview,
    this.createdAt,
    this.updatedAt,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'],
      userId: json['user_id'],
      personalOverview: json['personal_overview'],
      personalImage: json['personal_image'],
      wallet: json['wallet'],
      isAvailable: json['is_available'],
      totalProject: json['total_project'],
      rating: json['Rating'],
      totalSpend: json['total_spend'],
      totalReview: json['total_review'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['personal_overview'] = personalOverview;
    data['personal_image'] = personalImage;
    data['wallet'] = wallet;
    data['is_available'] = isAvailable;
    data['total_project'] = totalProject;
    data['Rating'] = rating;
    data['total_spend'] = totalSpend;
    data['total_review'] = totalReview;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
