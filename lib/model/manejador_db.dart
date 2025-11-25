// lib/model/manejador_db.dart

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'album.dart';
import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class ManejadorDatabase {
  
  static Database? _baseDatos;
  

  ManejadorDatabase._privateConstructor();
  static final ManejadorDatabase instance = ManejadorDatabase._privateConstructor();

  
  Future<Database> get database async {
    if (_baseDatos != null) {
      return _baseDatos!;
    }
    
    
    _baseDatos = await _initDatabase();
    return _baseDatos!;
  }

  
  Future<Database> _initDatabase() async {
    
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    String path = await getDatabasesPath();
    String rutaCompleta = join(path, 'mis_albumes.db');

    return await openDatabase(
      rutaCompleta,
      version: 1,
      onCreate: _crearTabla,
    );
  }

  
  Future _crearTabla(Database db, int version) async {
    await db.execute('''
      CREATE TABLE albumes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titulo TEXT NOT NULL,
        artista TEXT NOT NULL,
        anio INTEGER,
        genre TEXT NOT NULL
      )
    ''');
  }

  
  Future<int> insertar(Album album) async {
    Database db = await instance.database;
    return await db.insert('albumes', album.toMap());
  }

  
  Future<List<Album>> obtenerTodos() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> mapas = await db.query('albumes');
    
    
    return List.generate(mapas.length, (i) {
      return Album.fromMap(mapas[i]);
    });
  }

  // Actualizar
  Future<int> actualizar(Album album) async {
    Database db = await instance.database;
    return await db.update(
      'albumes',
      album.toMap(),
      where: 'id = ?',
      whereArgs: [album.id],
    );
  }

  // Borrar
  Future<int> borrar(int id) async {
    Database db = await instance.database;
    return await db.delete(
      'albumes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Cerrar conexion
  Future cerrar() async {
    Database db = await instance.database;
    db.close();
  }
}