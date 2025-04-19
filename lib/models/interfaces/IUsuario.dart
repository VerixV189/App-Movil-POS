import 'package:test/models/interfaces/IRol.dart';

class Usuario {
  final int id;
  final String nombre;
  final String username;
  final String email;
  final String? url_profile;
  final String? fecha_creacion;
  final String? fecha_actualizacion;
  final Rol? rol;

  Usuario({
    required this.id,
    required this.nombre,
    required this.email,
    required this.username,
    required this.url_profile,
    required this.fecha_creacion,
    required this.fecha_actualizacion,
    required this.rol
  });

  // Método para convertir el JSON recibido del backend en un objeto Usuario
  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
      username: json['username'],
      url_profile: json['url_profile'],
      fecha_creacion: json['fecha_creacion'],
      fecha_actualizacion: json['fecha_actualizacion'],
      // rol: Rol.fromJson(json['rol'])//debe serializar el json como el schema indicamos que serializar
      rol:
          json['rol'] != null && json['rol'] is Map<String, dynamic>
              ? Rol.fromJson(json['rol'])
              : Rol(id: 0, nombre: 'Desconocido'),
    );
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {'id': id,
     'nombre': nombre,
      'email': email,
       'username': username,
       'url_profile':url_profile
       ,'rol':rol?.toJson(),'fecha_creacion':fecha_creacion,'fecha_actualizacion':fecha_actualizacion};
  }
}
