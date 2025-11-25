// lib/model/album.dart

enum Genre { undefined, ct, rock, pop, regional }

const Map<Genre, String> genres = {
  Genre.undefined: "Sin definir",
  Genre.ct: "ꛕͲ",
  Genre.rock: "Rock",
  Genre.pop: "Pop",
  Genre.regional: "Regional",
};

class Album {
  int? id;
  String titulo;
  String artista;
  int anio;
  Genre genre;

  // Constructor normal
  Album({
    this.id,
    required this.titulo,
    required this.artista,
    required this.anio,
    required this.genre,
  });

  // Constructor para cuando esta vacio
  Album.vacio({
    this.id = 0,
    this.titulo = "",
    this.artista = "",
    this.anio = 0,
    this.genre = Genre.undefined,
  });

  // Convertir de Map a Objeto (Para leer de la BD)
  Album.fromMap(Map<String, dynamic> map) 
      : id = map['id'],
        titulo = map['titulo'],
        artista = map['artista'],
        anio = map['anio'],
        genre = Genre.values.byName(map['genre']);

  // Convertir de Objeto a Map (Para guardar en BD)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'artista': artista,
      'anio': anio,
      'genre': genre.name,
    };
  }

  // Getter para el texto del genero
  String get generos {
    return genres[genre] ?? "Desconocido";
  }
}