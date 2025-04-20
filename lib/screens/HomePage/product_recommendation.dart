import 'package:flutter/material.dart';
import 'package:test/models/ProductoMostradorDTO.dart';
import 'package:test/models/interfaces/IProducto.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/producto_service.dart';
import 'package:test/screens/HomePage/ProductDetailPage.dart';

class ProductRecommendationCarousel extends StatefulWidget {
  final String categoria;
  final int idProducto;

  const ProductRecommendationCarousel({
    super.key,
    required this.idProducto,
    required this.categoria,
  });

  @override
  State<ProductRecommendationCarousel> createState() =>
      _ProductRecommendationCarouselState();
}

class _ProductRecommendationCarouselState
    extends State<ProductRecommendationCarousel> {
  late Future<List<ProductoMostradorDTO>> _productosRecomendados;

  @override
  void initState() {
    super.initState();

    _productosRecomendados = ProductoService.getProductosInteligentes(
      id: widget.idProducto,
      nombre: widget.categoria,
    );


  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ProductoMostradorDTO>>(
      future: _productosRecomendados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: LinearProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Text("No se pudo cargar recomendaciones."),
          );
        }

        final productos = snapshot.data!;
        if (productos.isEmpty) return const SizedBox();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Te puede interesar",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 220,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: productos.length,
                separatorBuilder: (_, __) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final producto = productos[index];
                  final imagen =
                      producto.imagenes.isNotEmpty
                          ? producto.imagenes[0].es_google_image
                              ? producto.imagenes[0].url_image
                              : '${Server.CLOUDINARY_URL}/${producto.imagenes[0].url_image}'
                          : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQRgqXOaurAcnqRpVD2yJE0mfRyLh1k7CUEVA&s';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => ProductDetailPage(productId: producto.id),
                        ),
                      );
                    },
                    child: Container(
                      width: 160,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.grey.shade300, blurRadius: 4),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Hero(
                              tag: producto.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  imagen,
                                  fit: BoxFit.contain,
                                  width: double.infinity,
                                  errorBuilder:
                                      (_, __, ___) =>
                                          const Icon(Icons.broken_image),
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
                                  producto.estado == "DISPONIBLE"
                                      ? Colors.green.shade100
                                      : (producto.estado == "NO DISPONIBLE"
                                          ? Colors.red.shade100
                                          : Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              producto.estado ?? 'Sin estado',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color:
                                    producto.estado == "DISPONIBLE"
                                        ? Colors.green.shade800
                                        : (producto.estado == "NO DISPONIBLE"
                                            ? Colors.red.shade800
                                            : Colors.black54),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            producto.modelo.nombre,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            '${producto.precio} Bs',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
