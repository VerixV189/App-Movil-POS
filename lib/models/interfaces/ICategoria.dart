class Categoria {
  final int id;
  final String nombre;
  final String? fecha_creacion;
  final String? fecha_actualizacion;

  Categoria({required this.id, required this.nombre,this.fecha_creacion,this.fecha_actualizacion});

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      nombre: json['nombre'],
      fecha_creacion: json['fecha_creacion'], 
      fecha_actualizacion: json['fecha_actualizacion'], 
    );
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'fecha_creacion': fecha_creacion,
      'fecha_actualizacion': fecha_actualizacion,
    };
  }
}
