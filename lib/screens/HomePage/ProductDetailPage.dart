import 'package:flutter/material.dart';
import 'package:test/widgets/reviews/add_comment_modal.dart';
import 'package:test/widgets/reviews/rating_summary.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, dynamic> product;

  // Simulación: de carrusel de imagenes
  static const List<String> images = [
    "https://cdn-files.kimovil.com/phone_front/0007/75/thumb_674950_phone_front_big.jpg",
    "https://cdn-files.kimovil.com/default/0007/75/thumb_674948_default_big.jpg",
    "https://cdn-files.kimovil.com/default/0007/75/thumb_674938_default_big.jpg",
    "https://cdn-files.kimovil.com/default/0007/75/thumb_674947_default_big.jpg",
  ];
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);


  // Simulación de comentarios
  final List<Map<String, dynamic>> comments = const [
    {
      'user': 'Yo',
      'date': '16/04/2025',
      'content': 'Muy buen producto, me encantó.',
      'isCurrentUser': true,
        'stars': 4,
    },
    {
      'user': 'Yo',
      'date': '12/04/2025',
      'content': 'Llegó rápido y en buen estado.',
      'isCurrentUser': true,
        'stars': 1,
    },
    {
      'user': 'María López',
      'date': '10/04/2025',
      'content': 'Buena relación calidad-precio.',
      'isCurrentUser': false,
        'stars': 2,
    },
    {
      'user': 'Carlos Torres',
      'date': '08/04/2025',
      'content': 'No es lo que esperaba. Podría mejorar.',
      'isCurrentUser': false,
        'stars': 3,
    },
    {
      'user': 'Juana P.',
      'date': '07/04/2025',
      'content': 'Excelente atención del vendedor.',
      'isCurrentUser': false,
        'stars': 5,
    },
    {
      'user': 'Luis G.',
      'date': '05/04/2025',
      'content': 'Volvería a comprarlo sin duda.',
        'stars': 5,
      'isCurrentUser': false,
    },
    {
      'user': 'Miriam V.',
      'date': '04/04/2025',
      'content': 'Buen empaque y cumple lo prometido.',
        'stars': 5,
      'isCurrentUser': false,
    },
    {
      'user': 'Rafael C.',
      'date': '02/04/2025',
      'content': 'Cumplió mis expectativas.',
        'stars': 5,
      'isCurrentUser': false,
    },
    {
      'user': 'Tania R.',
      'date': '01/04/2025',
      'content': 'Lo recomiendo, muy útil.',
        'stars': 5,
      'isCurrentUser': false,
    },
    {
      'user': 'Eduardo S.',
      'date': '30/03/2025',
      'content': 'Todo bien, gracias.',
      'isCurrentUser': false,
        'stars': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final List<String> images = product['images'] ?? ProductDetailPage.images;
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
        backgroundColor: Colors.cyan.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: product['id'],
              child: SizedBox(
                height: 280,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.92),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final imageUrl = images[index];
                    return AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(Icons.broken_image),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
            Text(
              product['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              '\$${product['price']}',
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
              averageRating: 4.6,
              totalRatings: 1555,
              ratingDistribution: {5: 1200, 4: 200, 3: 100, 2: 40, 1: 15},
            ),
            // Dentro de Column(...) en el body, justo después del botón "Agregar al carrito"
            //para la descripcion y carcateristicas
            const SizedBox(height: 24),
            const Text(
              "Descripción",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Este producto es ideal para quienes buscan rendimiento, diseño moderno y buena relación calidad-precio. "
              "Cuenta con materiales resistentes y un acabado premium, ideal para uso diario.",
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 24),
            const Text(
              "Características",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• Pantalla: 6.5\" AMOLED"),
                Text("• Procesador: Snapdragon 695"),
                Text("• RAM: 6 GB"),
                Text("• Almacenamiento: 128 GB"),
                Text("• Cámara: 64MP + 8MP + 2MP"),
                Text("• Batería: 5000 mAh"),
                Text("• Sistema: Android 13"),
              ],
            ),

            //para los comentarios
            const SizedBox(height: 24),

            const Text(
              "Comentarios",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...comments.map((comment) => _buildCommentTile(comment)),
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
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        builder: (context) {
                          return AddCommentModal(
                            onSubmit: (stars, comment) {
                              // Aquí guardarás el comentario y estrellas
                              print("Comentario: $comment");
                              print("Estrellas: $stars");
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.add_comment_outlined),
                    label: const Text("Agregar comentario"),
                  )
                  ,
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.expand_more),
                  label: const Text("Ver más"),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentTile(Map<String, dynamic> comment) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: comment['isCurrentUser'] ? Colors.cyan : Colors.grey,
          child: Text(comment['user'][0]),
        ),
        title: Text(comment['user']),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(comment['date'], style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < (comment['stars'] ?? 5)
                      ? Icons.star
                      : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                );
              }),
            ),
            const SizedBox(height: 6),
            Text(comment['content']),
          ],
        ),

        trailing:
            comment['isCurrentUser']
                ? PopupMenuButton<String>(
                  onSelected: (value) {
                    // Lógica futura para editar/eliminar
                  },
                  itemBuilder:
                      (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Editar'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Eliminar'),
                        ),
                      ],
                )
                : null,
      ),
    );
  }
}
