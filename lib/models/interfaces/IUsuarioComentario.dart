
class UsuarioComentario {
  final int id;
  final String username;
  final String url_profile;

  UsuarioComentario({
    required this.id,
    
    required this.username,
    required this.url_profile,
  });

  // Método para convertir el JSON recibido del backend en un objeto UsuarioComentario
  factory UsuarioComentario.fromJson(Map<String, dynamic> json) {
    return UsuarioComentario(
      id: json['id'],
      username: json['username'],
      url_profile: json['url_profile'],
    );
  }

  // Método para convertir un UsuarioComentario en un mapa JSON
  //UsuarioComentario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'url_profile': url_profile,
    };
  }
}
