
import 'package:flutter/material.dart';
import 'package:test/models/interfaces/IProducto.dart';
import 'package:test/screens/HomePage/ImageModalViewer.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/producto_service.dart';
import 'package:test/widgets/reviews/add_comment_modal.dart';
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
            body: Center(child: Text('Error al obtener el producto: ${snapshot.error}')),
          );
        }

        final producto = snapshot.data!;
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
                  ratingDistribution: _buildDistribution(producto.comentarios),
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

  Map<int, int> _buildDistribution(List comentarios) {
    final Map<int, int> dist = {};
    for (var c in comentarios) {
      dist[c.puntuacion] = (dist[c.puntuacion] ?? 0) + 1;
    }
    return dist;
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

  Widget _buildCommentTile(comentario) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.cyan,
          child: Text(comentario.usuario.username[0]),
        ),
        title: Text(comentario.usuario.username),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${comentario.fecha} - ${comentario.hora}',
              style: const TextStyle(fontSize: 12),
            ),
            Row(
              children: List.generate(5, (i) {
                return Icon(
                  i < comentario.puntuacion ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                );
              }),
            ),
            const SizedBox(height: 6),
            Text(comentario.descripcion),
          ],
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:test/screens/HomePage/ImageModalViewer.dart';
// import 'package:test/widgets/reviews/add_comment_modal.dart';
// import 'package:test/widgets/reviews/product_detail_modal.dart';
// import 'package:test/widgets/reviews/rating_summary.dart';

// class ProductDetailPage extends StatelessWidget {
//   final int productId;

//   // Simulación: de carrusel de imagenes
//   static const List<String> images = [
//     "https://cdn-files.kimovil.com/phone_front/0007/75/thumb_674950_phone_front_big.jpg",
//     "https://cdn-files.kimovil.com/default/0007/75/thumb_674948_default_big.jpg",
//     "https://cdn-files.kimovil.com/default/0007/75/thumb_674938_default_big.jpg",
//     "https://cdn-files.kimovil.com/default/0007/75/thumb_674947_default_big.jpg",
//   ];
//   const ProductDetailPage({Key? key, required this.productId}) : super(key: key);


//   // Simulación de comentarios
//   final List<Map<String, dynamic>> comments = const [
//     {
//       'user': 'Yo',
//       'date': '16/04/2025',
//       'content': 'Muy buen producto, me encantó.',
//       'isCurrentUser': true,
//         'stars': 4,
//     },
//     {
//       'user': 'Yo',
//       'date': '12/04/2025',
//       'content': 'Llegó rápido y en buen estado.',
//       'isCurrentUser': true,
//         'stars': 1,
//     },
//     {
//       'user': 'María López',
//       'date': '10/04/2025',
//       'content': 'Buena relación calidad-precio.',
//       'isCurrentUser': false,
//         'stars': 2,
//     },
//     {
//       'user': 'Carlos Torres',
//       'date': '08/04/2025',
//       'content': 'No es lo que esperaba. Podría mejorar.',
//       'isCurrentUser': false,
//         'stars': 3,
//     },
//     {
//       'user': 'Juana P.',
//       'date': '07/04/2025',
//       'content': 'Excelente atención del vendedor.',
//       'isCurrentUser': false,
//         'stars': 5,
//     },
//     {
//       'user': 'Luis G.',
//       'date': '05/04/2025',
//       'content': 'Volvería a comprarlo sin duda.',
//         'stars': 5,
//       'isCurrentUser': false,
//     },
//     {
//       'user': 'Miriam V.',
//       'date': '04/04/2025',
//       'content': 'Buen empaque y cumple lo prometido.',
//         'stars': 5,
//       'isCurrentUser': false,
//     },
//     {
//       'user': 'Rafael C.',
//       'date': '02/04/2025',
//       'content': 'Cumplió mis expectativas.',
//         'stars': 5,
//       'isCurrentUser': false,
//     },
//     {
//       'user': 'Tania R.',
//       'date': '01/04/2025',
//       'content': 'Lo recomiendo, muy útil.',
//         'stars': 5,
//       'isCurrentUser': false,
//     },
//     {
//       'user': 'Eduardo S.',
//       'date': '30/03/2025',
//       'content': 'Todo bien, gracias.',
//       'isCurrentUser': false,
//         'stars': 5,
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final List<String> images = product['images'] ?? ProductDetailPage.images;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(product['name']),
//         backgroundColor: Colors.cyan.shade700,
//         foregroundColor: Colors.white,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Hero(
//               tag: product['id'],
//               child: SizedBox(
//                 height: 280,
//                 child: PageView.builder(
//                   controller: PageController(viewportFraction: 0.92),
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     final imageUrl = images[index];

//                     return GestureDetector(
//                       onTap: () {
//                         showDialog(
//                           context: context,
//                           builder: (_) => ImageModalViewer(imageUrl: imageUrl),
//                         );
//                       },
//                       child: AspectRatio(
//                         aspectRatio: 1,
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(12),
//                           child: Image.network(
//                             imageUrl,
//                             fit: BoxFit.cover,
//                             width: double.infinity,
//                             loadingBuilder: (context, child, loadingProgress) {
//                               if (loadingProgress == null) return child;
//                               return const Center(
//                                 child: CircularProgressIndicator(),
//                               );
//                             },
//                             errorBuilder: (context, error, stackTrace) {
//                               return const Center(
//                                 child: Icon(Icons.broken_image),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),

            

//             const SizedBox(height: 20),
//             Text(
//               product['name'],
//               style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             Text(
//               '\$${product['price']}',
//               style: const TextStyle(fontSize: 20, color: Colors.cyan),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton.icon(
//               onPressed: () {},
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.cyan,
//                 padding: const EdgeInsets.symmetric(
//                   vertical: 12,
//                   horizontal: 20,
//                 ),
//               ),
//               icon: const Icon(Icons.add_shopping_cart),
//               label: const Text("Agregar al carrito"),
//             ),

//             const SizedBox(height: 24),
//             RatingSummary(
//               averageRating: 4.6,
//               totalRatings: 1555,
//               ratingDistribution: {5: 1200, 4: 200, 3: 100, 2: 40, 1: 15},
//             ),
//             // Dentro de Column(...) en el body, justo después del botón "Agregar al carrito"
//             //para la descripcion y carcateristicas
//             const SizedBox(height: 24),
//             const Text(
//               "Descripción",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Text(
//               "Este producto es ideal para quienes buscan rendimiento, diseño moderno y buena relación calidad-precio. "
//               "Cuenta con materiales resistentes y un acabado premium, ideal para uso diario.",
//               textAlign: TextAlign.justify,
//             ),

//             const SizedBox(height: 24),
//             const Text(
//               "Características",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text("• Pantalla: 6.5\" AMOLED"),
//                 Text("• Procesador: Snapdragon 695"),
//                 Text("• RAM: 6 GB"),
//                 Text("• Almacenamiento: 128 GB"),
//                 Text("• Cámara: 64MP + 8MP + 2MP"),
//                 Text("• Batería: 5000 mAh"),
//                 Text("• Sistema: Android 13"),
//               ],
//             ),

//             //para los comentarios
//             const SizedBox(height: 24),

//             const Text(
//               "Comentarios",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 8),
//             ...comments.map((comment) => _buildCommentTile(comment)),
//             const SizedBox(height: 16),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 OutlinedButton.icon(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//                         ),
//                         builder: (context) {
//                           return AddCommentModal(
//                             onSubmit: (stars, comment) {
//                               // Aquí guardarás el comentario y estrellas
//                               print("Comentario: $comment");
//                               print("Estrellas: $stars");
//                             },
//                           );
//                         },
//                       );
//                     },
//                     icon: const Icon(Icons.add_comment_outlined),
//                     label: const Text("Agregar comentario"),
//                   )
//                   ,
//                 OutlinedButton.icon(
//                   onPressed: () {},
//                   icon: const Icon(Icons.expand_more),
//                   label: const Text("Ver más"),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCommentTile(Map<String, dynamic> comment) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 6),
//       elevation: 2,
//       child: ListTile(
//         leading: CircleAvatar(
//           backgroundColor: comment['isCurrentUser'] ? Colors.cyan : Colors.grey,
//           child: Text(comment['user'][0]),
//         ),
//         title: Text(comment['user']),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(comment['date'], style: const TextStyle(fontSize: 12)),
//             const SizedBox(height: 4),
//             Row(
//               children: List.generate(5, (index) {
//                 return Icon(
//                   index < (comment['stars'] ?? 5)
//                       ? Icons.star
//                       : Icons.star_border,
//                   color: Colors.amber,
//                   size: 18,
//                 );
//               }),
//             ),
//             const SizedBox(height: 6),
//             Text(comment['content']),
//           ],
//         ),

//         trailing:
//             comment['isCurrentUser']
//                 ? PopupMenuButton<String>(
//                   onSelected: (value) {
//                     // Lógica futura para editar/eliminar
//                   },
//                   itemBuilder:
//                       (context) => [
//                         const PopupMenuItem(
//                           value: 'edit',
//                           child: Text('Editar'),
//                         ),
//                         const PopupMenuItem(
//                           value: 'delete',
//                           child: Text('Eliminar'),
//                         ),
//                       ],
//                 )
//                 : null,
//       ),
//     );
//   }
// }
