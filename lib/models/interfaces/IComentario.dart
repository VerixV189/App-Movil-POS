import 'package:test/models/interfaces/IUsuarioComentario.dart';

class Comentario {
  final int id;
  final String descripcion;
  final String fecha;
  final String hora;
  final int puntuacion;
  final UsuarioComentario usuario;

  Comentario({
    required this.id,
    required this.descripcion,
    required this.fecha,
    required this.hora,
    required this.puntuacion,
    required this.usuario,
  });

  // Método para construir desde JSON
  factory Comentario.fromJson(Map<String, dynamic> json) {
    return Comentario(
      id: json['id'],
      descripcion: json['descripcion'],
      fecha: json['fecha'],
      hora: json['hora'],
      puntuacion: json['puntuacion'],
      usuario: UsuarioComentario.fromJson(json['usuario']),
    );
  }

  // Método para convertir a JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descripcion': descripcion,
      'fecha': fecha,
      'hora': hora,
      'puntuacion': puntuacion,
      'usuario': usuario.toJson(),
    };
  }
}
