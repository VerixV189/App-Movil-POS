class UsuarioLoginResponseDTO {
  final String message;
  final String token;
  final Usuario usuario;

  UsuarioLoginResponseDTO({
    required this.message,
    required this.token,
    required this.usuario,
  });

  // Método para convertir el JSON recibido del backend en un objeto LoginResponse
  factory UsuarioLoginResponseDTO.fromJson(Map<String, dynamic> json) {
    return UsuarioLoginResponseDTO(
      message: json['message'],
      token: json['token'],
      //conversion de json a objeto usuario
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  // Método para convertir un UsuarioLoginResponse en un mapa JSON
  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token, 'usuario': usuario.toJson()};
  }
}

class Usuario {
  final int id;
  final String nombre;
  final String username;
  final String email;

  Usuario({required this.id, required this.nombre, required this.email, required this.username});

  // Método para convertir el JSON recibido del backend en un objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      username: json['username']
    );
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {'id': id,
     'nombre': nombre,
      'email': email,
      'username':username};
  }
}
