class Caracteristica {
  final int id;
  final String? modelo;
  final String? almacenamiento;
  final String? bateria;
  final String? camara;
  final String? color;
  final String? conectividad;
  final String? dimension;
  final bool? microfonoIntegrado;
  final String? pantalla;
  final String? peso;
  final String? procesador;
  final String? puertos;
  final String? ram;
  final String? resolucion;
  final String? sistemaOperativo;
  final String? tarjetaGrafica;

  Caracteristica({
    required this.id,
    this.modelo,
    this.almacenamiento,
    this.bateria,
    this.camara,
    this.color,
    this.conectividad,
    this.dimension,
    this.microfonoIntegrado,
    this.pantalla,
    this.peso,
    this.procesador,
    this.puertos,
    this.ram,
    this.resolucion,
    this.sistemaOperativo,
    this.tarjetaGrafica,
  });

  factory Caracteristica.fromJson(Map<String, dynamic> json) {
    return Caracteristica(
      id: json['id'],
      modelo: json['modelo'],
      almacenamiento: json['almacenamiento'],
      bateria: json['bateria'],
      camara: json['camara'],
      color: json['color'],
      conectividad: json['conectividad'],
      dimension: json['dimension'],
      microfonoIntegrado: json['microfono_integrado'],
      pantalla: json['pantalla'],
      peso: json['peso'],
      procesador: json['procesador'],
      puertos: json['puertos'],
      ram: json['ram'],
      resolucion: json['resolucion'],
      sistemaOperativo: json['sistema_operativo'],
      tarjetaGrafica: json['tarjeta_grafica'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modelo': modelo,
      'almacenamiento': almacenamiento,
      'bateria': bateria,
      'camara': camara,
      'color': color,
      'conectividad': conectividad,
      'dimension': dimension,
      'microfono_integrado': microfonoIntegrado,
      'pantalla': pantalla,
      'peso': peso,
      'procesador': procesador,
      'puertos': puertos,
      'ram': ram,
      'resolucion': resolucion,
      'sistema_operativo': sistemaOperativo,
      'tarjeta_grafica': tarjetaGrafica,
    };
  }
}
