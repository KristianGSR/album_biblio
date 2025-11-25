// lib/vistas/album_list.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; 

import 'package:album_biblio/model/albumbiblio.dart';
import 'package:album_biblio/model/album.dart';
import 'package:album_biblio/model/manejador_db.dart';

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
  bool yaCargoBD = false;
  late ManejadorDatabase manejadorDB;
  
  int selectedAlbum = 0;
  late AlbumBiblio albumes;

  @override
  void initState() {
    super.initState();
    manejadorDB = ManejadorDatabase.instance;
  }

  @override
  Widget build(BuildContext context) {
    albumes = Provider.of<AlbumBiblio>(context);

    // Cargar datos si no se han cargado
    if (yaCargoBD == false) {
      manejadorDB.obtenerTodos().then((lista) {
        albumes.setAlbumes(lista);
        
        if (mounted) {
          setState(() {
            yaCargoBD = true;
          });
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Biblioteca"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(value: 1, child: Text("Mi Cuenta (Firebase)")),
                const PopupMenuItem(value: 2, child: Text("Perfil Local")),
                const PopupMenuItem(value: 3, child: Text("Acerca de ...")),
                const PopupMenuItem(value: 4, child: Text("Cerrar Sesión")),
              ];
            },
            onSelected: (value) {
              if (value == 1) {
                Navigator.pushNamed(context, '/profile');
              } 
              else if (value == 2) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const PerfilUsuario()));
              } 
              else if (value == 3) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AcercaDe()));
              } 
              else if (value == 4) {
                // CERRAR SESIÓN
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: yaCargoBD == false
          ? const Center(child: CircularProgressIndicator())
          : mostrarLista(),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          capturarAlbum(context);
        },
        tooltip: 'Nuevo album',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget mostrarLista() {
    if (albumes.albumes.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              capturarAlbum(context);
            },
            child: const Text("Agregar Album"),
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(10),
      children: ListTile.divideTiles(
        context: context,
        color: Colors.red.shade900,
        tiles: crearItems(),
      ).toList(),
    );
  }

  List<Widget> crearItems() {
    var listaWidgets = <Widget>[];
    
    for (int i = 0; i < albumes.albumes.length; i++) {
      Album a = albumes.albumes[i];
      
      var tile = ListTile(
        leading: const Icon(Icons.album),
        title: Text(a.titulo),
        subtitle: Text("${a.artista}, Año: ${a.anio}, Género: ${a.generos}"),
        trailing: SizedBox(
          width: 120,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, 
            child: botonesAccion(i)
          )
        ),
        
        textColor: Theme.of(context).colorScheme.onSurface,
        iconColor: Theme.of(context).colorScheme.onSurface,
        tileColor: Theme.of(context).colorScheme.surface,
        selectedColor: Colors.white,
        selectedTileColor: Colors.red.shade900,
        
        selected: (selectedAlbum == i),
        onTap: () {
          setState(() {
            selectedAlbum = i;
          });
        },
      );
      
      listaWidgets.add(tile);
    }
    return listaWidgets;
  }

  Widget botonesAccion(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          tooltip: "Ver",
          icon: const Icon(Icons.search),
          onPressed: () {
            mostrarDetalle(index);
          },
        ),
        IconButton(
          tooltip: "Editar",
          icon: const Icon(Icons.edit),
          onPressed: () {
            editarAlbum(index);
          },
        ),
        IconButton(
          tooltip: "Eliminar",
          icon: const Icon(Icons.delete),
          onPressed: () {
            borrarAlbum(index);
          },
        ),
      ],
    );
  }

  void mostrarDetalle(int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AlbumVista(album: albumes.getAlbumByIndex(index)),
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
      int id = await manejadorDB.insertar(album);
      album.id = id;
      albumes.addAlbum(album);
    }
  }

  Future editarAlbum(int index) async {
    Album? album = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AlbumForm(album: albumes.getAlbumByIndex(index)),
      ),
    );
    if (album != null) {
      albumes.updateAlbum(index, album);
      manejadorDB.actualizar(album);
    }
  }

  void borrarAlbum(int index) {
    Album album = albumes.getAlbumByIndex(index);
    bool eliminado = albumes.removeAlbum(index);
    
    if (album.id != null) {
      manejadorDB.borrar(album.id!);
    }
  }
}