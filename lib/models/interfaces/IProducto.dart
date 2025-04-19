import 'package:test/models/interfaces/ICaracteristica.dart';
import 'package:test/models/interfaces/IComentario.dart';

import 'package:test/models/interfaces/IImagen.dart';
import 'package:test/models/interfaces/IModelo.dart';

class Producto {
  final int id;
  final Caracteristica caracteristica;
  final List<Comentario> comentarios;
  final List<Imagen> imagenes;
  final String descripcion;
  final String estado;
  final double media_puntaje;
  final Modelo modelo;
  final double precio;
  final String tiempo_garantia;

  Producto({
    required this.id,
    required this.modelo,
    required this.descripcion,
    required this.media_puntaje,
    required this.estado,
    required this.precio,
    required this.tiempo_garantia,
    required this.caracteristica,
    required this.comentarios,
    required this.imagenes
  });

  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      modelo: Modelo.fromJson(json['modelo']),
      descripcion: json['descripcion'],
      media_puntaje: json['media_puntaje'],
      estado: json['estado'],
      precio: json['precio'],
      tiempo_garantia: json['tiempo_garantia'],
      caracteristica: Caracteristica.fromJson(json['caracteristica']),
     comentarios:
          (json['comentarios'] ?? [])
              .map<Comentario>((e) => Comentario.fromJson(e))
              .toList(),
      imagenes:
          (json['imagenes'] ?? [])
              .map<Imagen>((e) => Imagen.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelo': modelo.toJson(),
      'descripcion': descripcion,
      'media_puntaje': media_puntaje,
      'estado': estado,
      'precio': precio,
      'tiempo_garantia': tiempo_garantia,
      'caracteristica': caracteristica.toJson(),
      'comentarios': comentarios.map((e) => e.toJson()).toList(),
      'imagenes': imagenes.map((e) => e.toJson()).toList()
    };
  }
}
