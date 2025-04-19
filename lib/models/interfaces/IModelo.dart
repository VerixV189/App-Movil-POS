import 'package:test/models/interfaces/ICategoria.dart';
import 'package:test/models/interfaces/IMarca.dart';

class Modelo {
  final int id;
  final String nombre;
  final Categoria? categoria;
  final Marca? marca;

  Modelo({required this.id, required this.nombre, this.categoria,this.marca});

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(id: json['id'],
     nombre: json['nombre'],
     //aqui remarco si en el caso el back no retorna el marca o categoria entonces  ponlo en nulo
      marca: json['marca'] != null ? Marca.fromJson(json['marca']) : null,
      categoria: json['categoria'] != null ? Categoria.fromJson(json['categoria']) : null,
     );
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {'id': id,
     'nombre': nombre,
     'marca':marca?.toJson(),
     'categoria':categoria?.toJson()};
  }
}
