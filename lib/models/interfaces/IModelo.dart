class Modelo {
  final int id;
  final String nombre;

  Modelo({required this.id, required this.nombre});

  factory Modelo.fromJson(Map<String, dynamic> json) {
    return Modelo(id: json['id'], nombre: json['nombre']);
  }

  // Método para convertir un Usuario en un mapa JSON
  //usuario.json lo pasa a diccionario
  Map<String, dynamic> toJson() {
    return {'id': id, 'nombre': nombre};
  }
}
