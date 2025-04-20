import 'package:test/models/interfaces/ProductoCardItem.dart';

class CardItem {
  final int id;
  final int cantidad;
  final double subTotal;
  final ProductoCardItem producto;

  CardItem({
    required this.id,
    required this.cantidad,
    required this.subTotal,
    required this.producto,
  });

  factory CardItem.fromJson(Map<String, dynamic> json) {
    return CardItem(
      id: json['id'],
      cantidad: json['cantidad'],
      subTotal: (json['sub_total'] as num).toDouble(),
      producto: ProductoCardItem.fromJson(json['producto']),
    );
  }
}
