import 'package:flutter/material.dart';
import 'screens/lista_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coleção de Jogos',
      debugShowCheckedModeBanner: false,
      home: const ListaScreen(),
    );
  }
}