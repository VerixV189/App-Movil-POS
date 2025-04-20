class ModeloProducto {
  final int id;
  final String nombre;

  ModeloProducto({required this.id, required this.nombre});

  factory ModeloProducto.fromJson(Map<String, dynamic> json) {
    return ModeloProducto(id: json['id'], nombre: json['nombre']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'nombre': nombre};
}
