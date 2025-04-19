import 'package:test/models/interfaces/IImagen.dart';
import 'package:test/models/interfaces/IModelo.dart';

class ProductoMostradorDTO {
  final int id; //id del producto
  final Modelo modelo; // hace referencia al nombre del producto, es el modelo.nombre
  final double precio; //hace referencia al precio del producto
  final List<Imagen> imagenes;
  final String? estado;

  ProductoMostradorDTO({
    required this.id,
    required this.modelo,
    required this.precio,
    required this.imagenes,
    this.estado,
  });

  // Método fromJson para convertir un Map JSON a un objeto ProductoMostradorDTO
  factory ProductoMostradorDTO.fromJson(Map<String, dynamic> json) {
    return ProductoMostradorDTO(
      id: json['id'],
      modelo: Modelo.fromJson(json['modelo']),
      precio: json['precio'],
      imagenes:
          (json['imagenes'] as List<dynamic>)
              .map((img) => Imagen.fromJson(img))
              .toList(),
      estado: json['estado'],
    );
  }

  // Método toJson para convertir el objeto a un Map JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': modelo.toJson(),
      'precio': precio,
      'imagenes': imagenes.map((img) => img.toJson()).toList(),
      'estado': estado,
    };
  }
}
