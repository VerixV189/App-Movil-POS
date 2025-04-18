class Usuario {
  final int id;
  final String nombre;
  final String username;
  final String email;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.username,
  });

  // Método para convertir el JSON recibido del backend en un objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      username: json['username'],
    );
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre, 'email': email, 'username': username};
  }
}
