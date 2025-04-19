import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/ProductoProvider.dart';
import 'package:test/screens/HomePage/ProductDetailPage.dart';
import 'package:test/services/API/server_url.dart';

class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final productos = context.watch<ProductProvider>().productos;

    if (productos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: productos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = productos[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: product.toJson()),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ✅ Que la imagen se expanda pero no empuje a los demás
                Expanded(
                  child: Hero(
                    tag: product.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product.imagenes.isNotEmpty
                            ? (product.imagenes[0].es_google_image
                                ? product.imagenes[0].url_image
                                : '${Server.CLOUDINARY_URL}/${product.imagenes[0].url_image}')
                            : 'https://www.hostinger.com/es/tutoriales/wp-content/uploads/sites/7/2024/04/Error-404.png',
                        fit: BoxFit.contain,
                        errorBuilder:
                            (_, __, ___) => const Icon(Icons.broken_image),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color:
                        product.estado == "DISPONIBLE"
                            ? Colors.green.shade100
                            : (product.estado == "NO DISPONIBLE"
                                ? Colors.red.shade100
                                : Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    product.estado ?? 'Sin estado',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color:
                          product.estado == "DISPONIBLE"
                              ? Colors.green.shade800
                              : (product.estado == "NO DISPONIBLE"
                                  ? Colors.red.shade800
                                  : Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  product.modelo.nombre,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                Text(
                  '\ ${product.precio} Bs',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.green, fontSize: 13),
                ),
              ],
            ),
          );

        },
      ),
    );
  }
} 