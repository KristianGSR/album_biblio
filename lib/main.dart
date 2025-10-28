// lib/main.dart
import 'package:flutter/material.dart';
// Importa la nueva vista que creaste
import 'package:album_biblio/views/album_list.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlbumBiblio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // Llama aquí a tu nueva pantalla
      home: const AlbumLista(), 
    );
  }
}
