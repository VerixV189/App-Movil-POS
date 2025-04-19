import 'package:flutter/material.dart';
import 'package:test/models/interfaces/IComentario.dart';
import 'package:test/models/interfaces/IProducto.dart';
import 'package:test/screens/HomePage/ImageModalViewer.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/producto_service.dart';
import 'package:test/widgets/reviews/add_comment_modal.dart';
import 'package:test/widgets/reviews/comment_card.dart';
import 'package:test/widgets/reviews/rating_summary.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({Key? key, required this.productId})
    : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Producto> _productoFuture;

  @override
  void initState() {
    super.initState();
    _loadProducto();
  }

  void _loadProducto() {
    _productoFuture = ProductoService.getProductoCompleto(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Producto>(
      future: _productoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          print('❌ Error en ProductDetailPage: ${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Text('Error al obtener el producto: ${snapshot.error}'),
            ),
          );
        }

        final producto = snapshot.data!;
        print("📊 Estadísticas de puntuaciones: ${producto.estadisticas}");

        final imagenes = producto.imagenes.map((e) => e.url_image).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(producto.modelo.nombre),
            backgroundColor: Colors.cyan.shade700,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: producto.id,
                  child: SizedBox(
                    height: 280,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.92),
                      itemCount: imagenes.length,
                      itemBuilder: (context, index) {
                        final imageUrl = imagenes[index];

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => ImageModalViewer(imageUrl: imageUrl),
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Center(
                                          child: Icon(Icons.broken_image),
                                        ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  producto.modelo.nombre,

                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\ ${producto.precio} Bs',
                  style: const TextStyle(fontSize: 20, color: Colors.cyan),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                  ),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text("Agregar al carrito"),
                ),
                const SizedBox(height: 24),

                RatingSummary(
                  averageRating: producto.media_puntaje,
                  totalRatings: producto.comentarios.length,
                  ratingDistribution: producto.estadisticas,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Descripción",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(producto.descripcion, textAlign: TextAlign.justify),
                const SizedBox(height: 24),
                const Text(
                  "Características",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._buildCaracteristicas(producto.caracteristica),
                const SizedBox(height: 24),
                const Text(
                  "Comentarios",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                producto.comentarios.isEmpty
                    ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          "Este producto aún no tiene comentarios.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                    : Column(
                      children:
                          producto.comentarios.map(_buildCommentTile).toList(),
                    ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return AddCommentModal(
                              onSubmit: (stars, comment) {
                                print("Comentario: \$comment");
                                print("Estrellas: \$stars");
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.add_comment_outlined),
                      label: const Text("Agregar comentario"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildCaracteristicas(caract) {
    final Map<String, String?> map = {
      'Modelo': caract.modelo,
      'Pantalla': caract.pantalla,
      'RAM': caract.ram,
      'Almacenamiento': caract.almacenamiento,
      'Procesador': caract.procesador,
      'Sistema Operativo': caract.sistemaOperativo,
      'Batería': caract.bateria,
      'Resolución': caract.resolucion,
      'Cámara': caract.camara,
      'Puertos': caract.puertos,
    };
    return map.entries
        .where((e) => e.value != null)
        .map((e) => Text("\u2022 \ ${e.key}: \ ${e.value}"))
        .toList();
  }

  Widget _buildCommentTile(Comentario comentario) {
    return CommentCard(
      username: comentario.usuario.username,
      date: '${comentario.fecha} - ${comentario.hora}',
      content: comentario.descripcion,
      stars: comentario.puntuacion,
      isCurrentUser:
          false, // o lógica para verificar si es el usuario autenticado
    );
  }
}
