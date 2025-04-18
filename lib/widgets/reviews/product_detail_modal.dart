import 'package:flutter/material.dart';

class ProductDetailModal extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailModal({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.85,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 5,
                width: 50,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            Text(
              product['name'] ?? 'Nombre del producto',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$${product['price'] ?? '--'}",
              style: const TextStyle(fontSize: 18, color: Colors.cyan),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  product['description'] ?? "No hay descripción disponible",
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Agregar al carrito"),
            ),
          ],
        ),
      ),
    );
  }
}
