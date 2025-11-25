// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:album_biblio/model/albumbiblio.dart';

// Importaciones de Firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:album_biblio/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart'; // Para Google

// Importaciones de idioma
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'model/etiquetas_esp.dart'; // Tus traducciones

// Importaciones de vistas
import 'vistas/pagina_login.dart';
import 'vistas/album_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Inicializar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2. Configurar los proveedores (Correo y Google)
  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    // Esto habilita el boton de "Entrar con Google"
    GoogleProvider(clientId: DefaultFirebaseOptions.currentPlatform.appId),
  ]);

  runApp(
    ChangeNotifierProvider(
      create: (_) => AlbumBiblio(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AlbumBiblio',
      debugShowCheckedModeBanner: false,

      // TEMA ROJO Y NEGRO
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 192, 3, 3),
          onPrimary: Colors.white,
          secondary: Colors.redAccent,
          background: Color.fromARGB(255, 3, 3, 3),
          surface: Color.fromARGB(255, 3, 3, 3),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 192, 3, 3),
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: const Color.fromARGB(255, 3, 3, 3),
        useMaterial3: true,
      ),

      // IDIOMA ESPAÑOL
      localizationsDelegates: [
        FirebaseUILocalizations.withDefaultOverrides(const EtiquetasEsp()),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        FirebaseUILocalizations.delegate,
      ],
      supportedLocales: const [Locale('es', 'MX')],

      // NAVEGACIÓN (Login <-> Home)
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/home',
      routes: {
        '/login': (context) => const PaginaLogin(),
        '/home': (context) => const AlbumLista(),
        '/profile': (context) => ProfileScreen(
          actions: [
            SignedOutAction((context) {
              Navigator.pushReplacementNamed(context, '/login');
            }),
          ],
        ),
      },
    );
  }
}