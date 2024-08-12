import 'package:freelancing/models/freelancer.dart';

class Team {
   String name;
   List<Freelancer> freelancers;

  Team({
    required this.name,
    required this.freelancers,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    var freelancersJson = json['freelancers'] as List;
    List<Freelancer> freelancersList = freelancersJson.map((i) => Freelancer.fromJson(i)).toList();

    return Team(
      name: json['name'],
      freelancers: freelancersList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'freelancers': freelancers.map((freelancer) => freelancer.toJson()).toList(),
    };
  }
}
