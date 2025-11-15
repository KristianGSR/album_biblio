// lib/vistas/album_list.dart

import 'package:flutter/material.dart';
import 'package:album_biblio/model/albumbiblio.dart';
import 'package:album_biblio/model/album.dart';
import 'package:provider/provider.dart';

import 'package:album_biblio/vistas/album_vista.dart';
import 'package:album_biblio/vistas/perfil_usuario.dart';
import 'package:album_biblio/vistas/album_form.dart';
import 'package:album_biblio/vistas/acerca_de.dart';

class AlbumLista extends StatefulWidget {
  const AlbumLista({super.key});

  @override
  State<AlbumLista> createState() => _AlbumListaState();
}

class _AlbumListaState extends State<AlbumLista> {
  int selectedAlbum = 0;
  late AlbumBiblio albumes;

  @override
  Widget build(BuildContext context) {
    albumes = Provider.of<AlbumBiblio>(context);

    return Scaffold(
      appBar: AppBar(
        
        title: const Text("Biblioteca de Álbumes"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(value: 1, child: Text("Perfíl del usuario")),
              const PopupMenuItem(value: 2, child: Text("Acerca de ...")),
            ],
            onSelected: (value) {
              setState(() {
                if (value == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PerfilUsuario()));
                } else if (value == 2) {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AcercaDe()));
                }
              });
            },
          ),
        ],
      ),
      
      body: (albumes.albumes.isNotEmpty)
          ? ListView(
              padding: const EdgeInsets.all(10),
              children: ListTile.divideTiles(
                      
                      context: context,
                      tiles: crearLista(),
                      color: Colors.red.shade900)
                  .toList(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    capturarAlbum(context);
                  },
                  child: const Text("Agregar Album"),
                ),
              ),
            ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          capturarAlbum(context);
        },
        tooltip: 'Nuevo album',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> crearLista() {
    final List<Widget> lista = [];
    for (int i = 0; i < albumes.albumes.length; i++) {
      Album album = albumes.albumes[i];
      lista.add(ListTile(
          leading: const Icon(Icons.album),
          title: Text(album.titulo),
          subtitle: Text(
              "${album.artista}, Año: ${album.anio}, Género: ${album.generos}"),
          trailing: SizedBox(
              width: 120,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal, child: crearButtonsBar(i))),

          
          textColor: Theme.of(context).colorScheme.onSurface, // Texto blanco
          iconColor: Theme.of(context).colorScheme.onSurface, // Iconos blancos
          tileColor: Theme.of(context).colorScheme.surface, // Fondo negro
          selectedColor: Colors.white, // Texto blanco al seleccionar
          selectedTileColor:
              Colors.red.shade900, // Fondo rojo oscuro al seleccionar
          

          selected: (selectedAlbum == i),
          onTap: () => albumTapped(i)));
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
            onPressed: () {
              mostrarAlbum(context, index);
            },
            icon: const Icon(Icons.search)),
        IconButton(
            tooltip: "Editar",
            onPressed: () {
              actualizarAlbum(context, index); // Llama a la función de actualizar
            },
            icon: const Icon(Icons.edit)),
        IconButton(
            tooltip: "Eliminar",
            onPressed: () {
              removerAlbum(index); // Llama a la función de remover
            },
            icon: const Icon(Icons.delete)),
      ],
    );
  }

  void mostrarAlbum(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            AlbumVista(album: albumes.getAlbumByIndex(index)),
      ),
    );
  }

  Future capturarAlbum(BuildContext context) async {
    final Album? album = await Navigator.push(
      context,
      MaterialPageRoute(
        
        builder: (context) => const AlbumForm(),
      ),
    );
    if (album != null) {
      albumes.addAlbum(album);
      albumes.guardarAlbumes();
    }
  }

  Future actualizarAlbum(BuildContext context, int index) async {
    Album? album = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            
            AlbumForm(album: albumes.getAlbumByIndex(index)),
      ),
    );
    if (album != null) {
      albumes.updateAlbum(index, album);
      albumes.guardarAlbumes();
    }
  }

  bool removerAlbum(int index) {
    bool removido = albumes.removeAlbum(index);
    if (removido) {
      albumes.guardarAlbumes();
    }
    return removido;
  }
}