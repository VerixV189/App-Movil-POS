class Rol {
  final int id;
  final String nombre;

  Rol({required this.id, required this.nombre});

  factory Rol.fromJson(Map<String, dynamic> json) {
    return Rol(
      id: json['id'],
      nombre: json['nombre'],
    );
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
    };
  }
}
