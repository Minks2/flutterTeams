// lib/data/team_repository.dart
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:excheckp/models/teams.dart';

class TeamRepository {
  Future<List<Team>> fetchTeams() async {
    final jsonString = await rootBundle.loadString('assets/data/teams.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Team.fromJson(json)).toList();
  }
}