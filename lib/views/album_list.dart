

import 'package:flutter/material.dart';

import 'package:album_biblio/model/albumbiblio.dart';

// (Widget principal que crea el estado)
class AlbumLista extends StatefulWidget {
  const AlbumLista({Key? key}) : super(key: key);

  @override
  State<AlbumLista> createState() => _AlbumListaState();
}

// (Clase de estado que contiene toda la lógica de la pantalla)
class _AlbumListaState extends State<AlbumLista> {
  
  
  int selectedAlbum = 0;
  late AlbumBiblio albumes;

  @override
  void initState() {
    super.initState();
    albumes = AlbumBiblio();
    albumes.addAlbum(Album( titulo: "Mi Vida Mi Muerte",
        artista: "Neton Vega", anio: 2025, genre: "CT"));
    albumes.addAlbum(Album( titulo: "TATTOO",
        artista: "Tito Double P", anio: 2025, genre: "CT"));
    albumes.addAlbum(Album( titulo: "Por Esos Ojos",
        artista: "Fuerza Regida", anio: 2025, genre: "CT"));
    albumes.addAlbum(Album( titulo: "El Niño",
        artista: "Gabito Ballesteros", anio: 2023, genre: "CT"));
    albumes.addAlbum(Album( titulo: "Corridos Tumbados",
        artista: "Natanael Cano", anio: 2019, genre: "CT"));
    albumes.addAlbum(Album( titulo: "Génesis",
        artista: "Peso Pluma", anio: 2023, genre: "CT"));
    albumes.addAlbum(Album( titulo: "Atrapado en un Sueño",
        artista: "Junior H", anio: 2020, genre: "CT"));
    albumes.addAlbum(Album( titulo: "Nata Montana",
        artista: "Natanael Cano", anio: 1975, genre: "CT"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Biblioteca de Álbumes"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: ListTile.divideTiles(context: context,
            tiles: crearLista(), color: Colors.amber).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          // Acción para agregar nuevo álbum (aún vacía)
        },
        tooltip: 'Nuevo album',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Define el tipo de retorno como List<Widget>
  List<Widget> crearLista() {
    final List<Widget> lista = [];
    for (int i = 0; i < albumes.albumes.length; i++) {
      Album album = albumes.albumes[i];
      lista.add(
        ListTile(
          leading: const Icon(Icons.album),
          title: Text(album.titulo),
          subtitle: Text("${album.artista}, Año: ${album.anio}, Género: ${album.genre}"),
          trailing: SizedBox(width: 120,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: crearButtonsBar(i))),
          textColor: Colors.white,
          tileColor: Colors.lightBlue,
          selectedColor: Colors.blue,
          selectedTileColor: Colors.deepOrange.shade100,
          selected: (selectedAlbum == i),
          onTap: () => albumTapped(i)
        )
      );
    }
    return lista;
  }

  void albumTapped(int i) {
    setState(() {
      selectedAlbum = i;
    });
  }

  Widget crearButtonsBar(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            tooltip: "Ver",
            onPressed: () { }, // Acción (aún vacía)
            icon: const Icon(Icons.search)),
        IconButton(
            tooltip: "Editar",
            onPressed: () { }, // Acción (aún vacía)
            icon: const Icon(Icons.edit)),
        IconButton(
            tooltip: "Eliminar",
            onPressed: () { }, // Acción (aún vacía)
            icon: const Icon(Icons.delete)),
      ],
    );
  }
}