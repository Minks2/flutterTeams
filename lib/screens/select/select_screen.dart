// lib/screens/select_screen.dart
import 'package:flutter/material.dart';
import 'package:excheckp/data/favorite_repository.dart';
import 'package:excheckp/data/team_repository.dart';
import 'package:excheckp/models/teams.dart';

class SelectScreen extends StatelessWidget {
  final _teamRepository = TeamRepository();
  final _favoriteRepository = FavoriteRepository();

  SelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha seu time'),
      ), 
      body: FutureBuilder<List<Team>>(
        future: _teamRepository.fetchTeams(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar os times'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum time encontrado'));
          }

          final teams = snapshot.data!;
          return ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.asset(team.logo, width: 40),
                  title: Text(team.name),
                  onTap: () async {
                    // Salva o time escolhido
                    await _favoriteRepository.saveFavoriteTeam(team);
                    // Volta para a tela anterior (HomeScreen)
                    Navigator.pop(context);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}