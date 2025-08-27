// lib/main.dart
import 'package:flutter/material.dart';
import 'package:excheckp/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu Time Favorito',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
      ),
      initialRoute: Routes.home,
      onGenerateRoute: Routes.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}