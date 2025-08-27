// lib/models/team.dart
class Team {
  final int id;
  final String name;
  final String logo;

  Team({
    required this.id,
    required this.name,
    required this.logo,
  });

  // Converte um objeto JSON (Map) em um objeto Team
  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }

  // Converte um objeto Team em um objeto JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
    };
  }
}