import 'package:flutter/material.dart';
import 'package:album_biblio/model/albumbiblio.dart';

// PASO 1: Se agregaron los imports para las nuevas pantallas
import 'package:album_biblio/vistas/album_vista.dart';
import 'package:album_biblio/vistas/perfil_usuario.dart';

// (Tu widget principal no cambia)
class AlbumLista extends StatefulWidget {
  const AlbumLista({Key? key}) : super(key: key);

  @override
  State<AlbumLista> createState() => _AlbumListaState();
}

// (Tu clase de estado)
class _AlbumListaState extends State<AlbumLista> {
  int selectedAlbum = 0;
  late AlbumBiblio albumes;

  @override
  void initState() {
    super.initState();
    // Tu lista de álbumes se queda intacta
    albumes = AlbumBiblio();
    albumes.addAlbum(Album(
        titulo: "Mi Vida Mi Muerte",
        artista: "Neton Vega",
        anio: 2025,
        genre: "CT"));
    albumes.addAlbum(Album(
        titulo: "TATTOO",
        artista: "Tito Double P",
        anio: 2025,
        genre: "CT"));
    albumes.addAlbum(Album(
        titulo: "Por Esos Ojos",
        artista: "Fuerza Regida",
        anio: 2025,
        genre: "CT"));
    albumes.addAlbum(Album(
        titulo: "El Niño",
        artista: "Gabito Ballesteros",
        anio: 2023,
        genre: "CT"));
    albumes.addAlbum(Album(
        titulo: "Corridos Tumbados",
        artista: "Natanael Cano",
        anio: 2019,
        genre: "CT"));
    albumes.addAlbum(Album(
        titulo: "Génesis",
        artista: "Peso Pluma",
        anio: 2023,
        genre: "CT"));
    albumes.addAlbum(Album(
        titulo: "Atrapado en un Sueño",
        artista: "Junior H",
        anio: 2020,
        genre: "CT"));
    albumes.addAlbum(Album(
        titulo: "Nata Montana",
        artista: "Natanael Cano",
        anio: 1975,
        genre: "CT"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Biblioteca de Álbumes"),

        // PASO 2: Se agregó el menú de perfil (Código 7-26)
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                  value: 1, child: Text("Perfíl del usuario")),
              const PopupMenuItem(value: 2, child: Text("Acerca de ...")),
            ],
            onSelected: (value) {
              setState(() {
                if (value == 1) {
                  // NAVEGA A LA PANTALLA DE PERFIL
                  
                  // ===== INICIO DE LA CORRECCIÓN =====
                  Navigator.of(context).push(MaterialPageRoute(
                      // El nombre de la CLASE va con Mayúscula
                      builder: (context) => const PerfilUsuario()));
                  // ===== FIN DE LA CORRECCIÓN =====

                } else if (value == 2) {
                  // Aquí se mostrará una página con datos de la aplicación
                }
              });
            },
          ),
        ],
      ),
      // Tu body no cambia
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: ListTile.divideTiles(
                context: context, tiles: crearLista(), color: Colors.amber)
            .toList(),
      ),
      // Tu FloatingActionButton no cambia
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para agregar nuevo álbum (aún vacía)
        },
        tooltip: 'Nuevo album',
        child: const Icon(Icons.add),
      ),
    );
  }

  // Tu función crearLista no cambia
  List<Widget> crearLista() {
    final List<Widget> lista = [];
    for (int i = 0; i < albumes.albumes.length; i++) {
      Album album = albumes.albumes[i];
      lista.add(ListTile(
          leading: const Icon(Icons.album),
          title: Text(album.titulo),
          subtitle:
              Text("${album.artista}, Año: ${album.anio}, Género: ${album.genre}"),
          trailing: SizedBox(
              width: 120,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: crearButtonsBar(i))),
          textColor: Colors.white,
          tileColor: Colors.lightBlue,
          selectedColor: Colors.blue,
          selectedTileColor: Colors.deepOrange.shade100,
          selected: (selectedAlbum == i),
          onTap: () => albumTapped(i)));
    }
    return lista;
  }

  // Tu función albumTapped no cambia
  void albumTapped(int i) {
    setState(() {
      selectedAlbum = i;
    });
  }

  // Tu función crearButtonsBar SÍ cambia
  Widget crearButtonsBar(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            tooltip: "Ver",
            // PASO 3: Se modificó el onPressed del botón "Ver" (Código 7-24)
            onPressed: () {
              // Llama a la nueva función de navegación
              mostrarAlbum(context, index);
            },
            icon: const Icon(Icons.search)),
        // Tus otros botones no cambian
        IconButton(
            tooltip: "Editar",
            onPressed: () {}, // Acción (aún vacía)
            icon: const Icon(Icons.edit)),
        IconButton(
            tooltip: "Eliminar",
            onPressed: () {}, // Acción (aún vacía)
            icon: const Icon(Icons.delete)),
      ],
    );
  }

  // PASO 4: Se agregó la nueva función para navegar (Código 7-24)
  void mostrarAlbum(BuildContext context, int index) {
    // Obtenemos el álbum específico de tu lista
    Album albumSeleccionado = albumes.albumes[index];

    Navigator.of(context).push(
      MaterialPageRoute(
        // Le pasamos el álbum seleccionado a la nueva pantalla AlbumVista
        builder: (context) => AlbumVista(album: albumSeleccionado),
      ),
    );
  }
}