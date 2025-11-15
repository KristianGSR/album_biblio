// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:album_biblio/model/albumbiblio.dart';
import 'package:album_biblio/vistas/album_list.dart';

void main() {
  
  WidgetsFlutterBinding.ensureInitialized();

  
  AlbumBiblio.leerArchivo().then((albumes) {
    
    runApp(
      ChangeNotifierProvider(create: (_) {
        // Decide si empezar con una lista vacía o con la lista cargada
        AlbumBiblio albumBiblio = (albumes == null)
            ? AlbumBiblio() // No había archivo, empieza de cero
            : AlbumBiblio.fromJson(albumes); // Carga los datos del archivo
        return albumBiblio;
      }, child: const MyApp()),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlbumBiblio',
      
      
      theme: ThemeData(
        
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 192, 3, 3), // Rojo principal
          onPrimary: Colors.white,       
          secondary: Colors.redAccent,   
          background: Color.fromARGB(255, 3, 3, 3),   // Fondo negro
          onBackground: Colors.white,   
          surface: Color.fromARGB(255, 3, 3, 3),    // Fondo de "tarjetas" (negro)
          onSurface: Colors.white,      // Texto sobre las tarjetas (blanco)
        ),
        
        
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 192, 3, 3), // Fondo rojo
          foregroundColor: Colors.white, // Título y botones en blanco
        ),
        
        
        scaffoldBackgroundColor: const Color.fromARGB(255, 3, 3, 3),

        
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: const Color.fromARGB(255, 192, 3, 3), // Fondo rojo
          foregroundColor: Colors.black, // Color del ícono '+'
        ),
        
        
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 3, 3, 3), // Fondo negro
            foregroundColor: Colors.white, 
          ),
        ),
        
        useMaterial3: true,
      ),
      

      home: const AlbumLista(),
    );
  }
}