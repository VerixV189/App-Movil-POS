import 'package:test/models/interfaces/CardItem.dart';

class Carrito {
  final int id;
  final double montoTotal;
  final List<CardItem> cardItems;

  Carrito({
    required this.id,
    required this.montoTotal,
    required this.cardItems,
  });

  factory Carrito.fromJson(Map<String, dynamic> json) {
    final items = json['items'];
    return Carrito(
      id: items['id'],
      montoTotal: items['monto_total'] ,
      cardItems:
          (items['card_items'] as List)
              .map((item) => CardItem.fromJson(item))
              .toList(),
    );
  }
}
