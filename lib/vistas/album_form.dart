// lib/vistas/album_form.dart

import 'package:flutter/material.dart';
import '../model/album.dart';

class AlbumForm extends StatefulWidget {
  final Album? album;
  const AlbumForm({super.key, this.album});

  @override
  State<AlbumForm> createState() => _AlbumFormState();
}

class _AlbumFormState extends State<AlbumForm> {
  final _formkey = GlobalKey<FormState>();
  
  // Controladores
  final ctrTitulo = TextEditingController();
  final ctrArtista = TextEditingController();
  final ctrAnio = TextEditingController();

  var selectedGenre = Genre.undefined;
  String tituloForm = "";
  int? id;

  @override
  void initState() {
    super.initState();
    // Checamos si es editar o nuevo
    if (widget.album != null) {
      id = widget.album!.id;
      ctrTitulo.text = widget.album!.titulo;
      ctrArtista.text = widget.album!.artista;
      ctrAnio.text = widget.album!.anio.toString();
      selectedGenre = widget.album!.genre;
      tituloForm = "Editar Album";
    } else {
      tituloForm = "Nuevo Album";
    }
  }

  @override
  void dispose() {
    ctrTitulo.dispose();
    ctrArtista.dispose();
    ctrAnio.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tituloForm)),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Campo Titulo
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Título del album'),
                    controller: ctrTitulo,
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Proporcione un título';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  
                  // Campo Artista
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Intérprete'),
                    controller: ctrArtista,
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Falta el artista';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  
                  // Campo Año
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Año'),
                    keyboardType: TextInputType.number,
                    controller: ctrAnio,
                    validator: (valor) {
                      if (valor == null || valor.isEmpty) {
                        return 'Falta el año';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  
                  // Dropdown Genero
                  DropdownMenu(
                    initialSelection: selectedGenre,
                    label: const Text("Género"),
                    dropdownMenuEntries: genres.keys.map((key) {
                      return DropdownMenuEntry(value: key, label: genres[key]!);
                    }).toList(),
                    onSelected: (valor) {
                      setState(() {
                        selectedGenre = valor!;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  
                  // Botones
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: guardar, 
                        child: const Text("Aceptar")
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Cancelar")
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void guardar() {
    // Validamos el formulario
    if (_formkey.currentState!.validate() == false) {
      return;
    }
    
    // Creamos el objeto
    final nuevoAlbum = Album(
      id: id,
      titulo: ctrTitulo.text,
      artista: ctrArtista.text,
      anio: int.parse(ctrAnio.text),
      genre: selectedGenre,
    );
    
    // Regresamos
    Navigator.pop(context, nuevoAlbum);
  }
}