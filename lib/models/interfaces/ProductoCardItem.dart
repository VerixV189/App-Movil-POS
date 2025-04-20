import 'package:test/models/interfaces/IImagen.dart';
import 'package:test/models/interfaces/ModeloProducto.dart';

class ProductoCardItem {
  final int id;
  final double precio;
  final List<Imagen> imagenes;
  final ModeloProducto modelo;

  ProductoCardItem({
    required this.id,
    required this.precio,
    required this.imagenes,
    required this.modelo,
  });

  factory ProductoCardItem.fromJson(Map<String, dynamic> json) {
    return ProductoCardItem(
      id: json['id'],
      precio: json['precio'],
      imagenes:
          (json['imagenes'] as List)
              .map((img) => Imagen.fromJson(img))
              .toList(),
      modelo: ModeloProducto.fromJson(json['modelo']),
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'precio': precio,
      'imagenes': imagenes.map((e) => e.toJson()).toList(),
      'modelo': modelo.toJson(),
    };
  }
}
