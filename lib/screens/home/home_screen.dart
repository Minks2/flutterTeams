// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:excheckp/data/favorite_repository.dart';
import 'package:excheckp/models/teams.dart';
import 'package:excheckp/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _favoriteRepository = FavoriteRepository();
  Future<Team?>? _favoriteTeamFuture;

  @override
  void initState() {
    super.initState();
    _loadFavoriteTeam();
  }

  void _loadFavoriteTeam() {
    setState(() {
      _favoriteTeamFuture = _favoriteRepository.loadFavoriteTeam();
    });
  }

  void _removeFavoriteTeam() async {
    await _favoriteRepository.removeFavoriteTeam();
    _loadFavoriteTeam();
  }

  void _navigateToSelectScreen() async {
    // Aguarda o retorno da tela de seleção
    await Navigator.pushNamed(context, Routes.select);
    // Quando voltar, recarrega o time para atualizar a tela
    _loadFavoriteTeam();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu Time Favorito'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _removeFavoriteTeam,
            tooltip: 'Remover favorito',
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<Team?>(
          future: _favoriteTeamFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final team = snapshot.data;

            if (team != null) {
              // Exibe o time favorito
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _navigateToSelectScreen,
                    child: Image.asset(team.logo, height: 150),
                  ),
                  const SizedBox(height: 20),
                  Text(team.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              );
            } else {
              // Exibe a mensagem padrão
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _navigateToSelectScreen,
                    // Imagem genérica
                    child: const Icon(Icons.shield_outlined, size: 150, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Você ainda não escolheu seu time favorito.\nClique no escudo acima.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}