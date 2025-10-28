import 'package:flutter/material.dart';

void main() => runApp(const ProfileCardApp());

class ProfileCardApp extends StatelessWidget {
  const ProfileCardApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Tarjeta de Perfil',
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 192, 3, 3),
        body: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Center(
            child: GestureDetector(
              onTap: () => print("Evento onTap"),
              onDoubleTap: () => print("Evento onDoubleTap"),
              onVerticalDragEnd: (DragEndDetails endDetails) =>
                  print("Evento onVerticalDragEnd"),
              onHorizontalDragEnd: (DragEndDetails endDetails) =>
                  print("Evento onHorizontalDragEnd"),
              child: Container(
                width: 350,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  color: Color.fromARGB(255, 3, 3, 3),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/ct.jpeg'),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'ꛕͲ',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                      ),
                      Text(
                        'ꛕorridos Ͳumbados',
                        style: TextStyle(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 255, 251, 251),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Es un subgénero de la música regional mexicana, específicamente del corrido, con elementos de música urbana y narcocorrido. ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(221, 252, 252, 252),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.email, color: Color.fromARGB(244, 243, 179, 40)),
                          SizedBox(width: 8),
                          Text('LosCt@gmail.com',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255), // Color RGB
                            ),),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone, color: Colors.green),
                          SizedBox(width: 8),
                          Text('+52 662 630 8027',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255), // Color RGB
                            ),),
                          
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_on, color: Colors.red),
                          SizedBox(width: 8),
                          Text('Hermosillo, Sonora',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255), // Color RGB
                            ),),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}