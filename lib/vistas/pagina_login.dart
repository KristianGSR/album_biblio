// lib/vistas/pagina_login.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

class PaginaLogin extends StatelessWidget {
  const PaginaLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Si no hay usuario, mostramos el Login
        if (!snapshot.hasData) {
          return SignInScreen(
            // Acción al entrar correctamente
            actions: [
              AuthStateChangeAction<SignedIn>((context, state) {
                Navigator.pushReplacementNamed(context, '/home');
              }),
            ],
            
            // 1. LOGO (Encabezado)
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                
                child: Image.asset('assets/img/logo.png', height: 120),
              );
            },

            
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  action == AuthAction.signIn
                      ? "Bienvenido a AlbumBiblio. Inicie sesión."
                      : "Regístrese para crear su cuenta.",
                  textAlign: TextAlign.center,
                ),
              );
            },

            
            footerBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Column(
                  children: const [
                    Divider(),
                    Text(
                      "Gracias por su preferencia\nElaborado por Estudiantes del TecNM",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          );
        }

        // Si ya hay usuario, cargando...
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}