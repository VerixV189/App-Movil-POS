class Imagen {
  final int id;
  final String url_image;
  final bool es_google_image;

  Imagen({required this.id, required this.url_image, required this.es_google_image});

  factory Imagen.fromJson(Map<String, dynamic> json) {
    return Imagen(id: json['id'], url_image: json['cloudinary_id'], es_google_image: json['es_google_image']);
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {'id': id, 'url_image': url_image,'es_google_image':es_google_image};
  }
}
