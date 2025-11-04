// lib/vistas/album_vista.dart
import 'package:flutter/material.dart';
import 'package:album_biblio/model/albumbiblio.dart'; 

class AlbumVista extends StatelessWidget {
  final Album album;

  const AlbumVista({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(album.titulo),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Artista: ${album.artista}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              "Año: ${album.anio}",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  'Género: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  album.genre, // Usa tu 'genre' (String)
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 16),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}