// lib/model/albumbiblio.dart

import 'album.dart';
import 'package:flutter/material.dart';


import 'dart:convert'; 
import 'dart:io'; 
import 'package:path_provider/path_provider.dart'; 


class AlbumBiblio extends ChangeNotifier {
  final List<Album> _listaAlbumes = [];
  
  static String nombreArchivo = "albumes.json";

  AlbumBiblio(); 

  
  AlbumBiblio.fromJson(Map<String, dynamic> json) {
    List albumes = json["albumes"];
    for (int i = 0; i < albumes.length; i++) {
      _listaAlbumes.add(Album.fromJson(albumes[i]));
    }
  }

  
  List<Album> get albumes => _listaAlbumes;

  void addAlbum(Album album) {
    _listaAlbumes.add(album);
    notifyListeners();
  }

  bool updateAlbum(int index, Album album) {
    if (index >= 0 && index < _listaAlbumes.length) {
      _listaAlbumes[index] = album;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool removeAlbum(int index) {
    if (index >= 0 && index < _listaAlbumes.length) {
      _listaAlbumes.removeAt(index);
      notifyListeners();
      return true;
    }
    return false;
  }

  Album getAlbumByIndex(int index) {
    return _listaAlbumes[index];
  }

  
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> albumes = [];
    for (int i = 0; i < _listaAlbumes.length; i++) {
      albumes.add(_listaAlbumes[i].toJson());
    }
    Map<String, dynamic> mapa = {"albumes": albumes};
    return mapa;
  }

  
  static Future<String> get _pathLocal async {
    final directorio = await getApplicationDocumentsDirectory();
    return directorio.path;
  }

  
  static Future<File> get _archivoLocal async {
    final path = await _pathLocal;
    return File('$path${Platform.pathSeparator}$nombreArchivo');
  }

  
  Future<File> guardarAlbumes() async {
    final archivo = await _archivoLocal;
    
    return archivo.writeAsString(jsonEncode(toJson()));
  }

  
  static Future<Map<String, dynamic>?> leerArchivo() async {
    try {
      final archivo = await _archivoLocal;
      if (await archivo.exists()) { 
        String contenido = await archivo.readAsString();
        return jsonDecode(contenido);
      }
      return null; 
    } catch (e) {
      
      print("Error al leer archivo: $e");
      return null;
    }
  }
}