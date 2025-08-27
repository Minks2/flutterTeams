// lib/data/favorite_repository.dart
import 'dart:convert';
import 'package:excheckp/models/teams.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepository {
  static const _keyFavoriteTeam = 'favorite_team';

  Future<void> saveFavoriteTeam(Team team) async {
    final prefs = await SharedPreferences.getInstance();
    final teamJsonString = json.encode(team.toJson());
    await prefs.setString(_keyFavoriteTeam, teamJsonString);
  }

  Future<Team?> loadFavoriteTeam() async {
    final prefs = await SharedPreferences.getInstance();
    final teamJsonString = prefs.getString(_keyFavoriteTeam);
    if (teamJsonString != null) {
      return Team.fromJson(json.decode(teamJsonString));
    }
    return null;
  }

  Future<void> removeFavoriteTeam() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyFavoriteTeam);
  }
}