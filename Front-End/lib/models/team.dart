import 'package:freelancing/models/freelancer.dart';

class Team {
  final String name;
  List<Freelancer> freelancers;
  final List<TeamInvitation> invitations;
  

  Team({
    required this.name,
    required this.freelancers,
    required this.invitations,
  });

 factory Team.fromJson(Map<String, dynamic> json) {
  var freelancersJson = json['freelancers'] as List<dynamic>? ?? [];
  var invitationsJson = json['team_invitations'] as List<dynamic>? ?? [];  // Use a consistent key name
  
  List<TeamInvitation> invitationsList = invitationsJson.map((i) => TeamInvitation.fromJson(i)).toList(); 
  List<Freelancer> freelancersList = freelancersJson.map((i) => Freelancer.fromJson(i)).toList();

  return Team(
    name: json['name'] ?? '',  // Provide a default value in case 'name' is null
    freelancers: freelancersList,
    invitations: invitationsList,
  );
}


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'freelancers': freelancers.map((freelancer) => freelancer.toJson()).toList(),
    };
  }
}
class TeamInvitation {
  String? teamName;
  List<TeamInvintion>? teamInvintion;

  TeamInvitation.fromJson(Map<String, dynamic> json) {
    teamName = json['team name'];
    if (json['team invintion'] != null) {
      teamInvintion = <TeamInvintion>[];
      json['team invintion'].forEach((v) {
        teamInvintion!.add(new TeamInvintion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['team name'] = teamName;
    if (teamInvintion != null) {
      data['team invintion'] =
          this.teamInvintion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TeamInvintion {
  int? invitationId;
  int? freelancerId;
  String? freelancerName;
  String? freelancerStatus;
  String? createdAt;
  String? updatedAt;

  TeamInvintion(
      {this.invitationId,
      this.freelancerId,
      this.freelancerName,
      this.freelancerStatus,
     });

  TeamInvintion.fromJson(Map<String, dynamic> json) {
    invitationId = json['Invitation_id'];
    freelancerId = json['freelancer_id'];
    freelancerName = json['freelancer_name'];
    freelancerStatus = json['freelancer_status'];
 
  }

 Map<String, dynamic> toJson() {
    return {
      'Invitation_id': invitationId,
      'freelancer_id': freelancerId,
      'freelancer_name': freelancerName,
      'freelancer_status': freelancerStatus,
    };
  }
}