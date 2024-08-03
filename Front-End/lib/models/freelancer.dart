class Freelancer {
  final int id;
  final String name;
  final String status;

  Freelancer({
    required this.id,
    required this.name,
    required this.status,
  });

  factory Freelancer.fromJson(Map<String, dynamic> json) {
    return Freelancer(
      id: json['id'],
      name: json['name'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }
}
