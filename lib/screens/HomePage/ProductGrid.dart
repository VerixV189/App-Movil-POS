import 'package:flutter/material.dart';
import 'package:test/screens/HomePage/ProductDetailPage.dart';


class ProductGrid extends StatelessWidget {
  const ProductGrid({super.key});

  final List<Map<String, dynamic>> products = const [
    {
      'id': 'prod1',
      'image':
          'https://cdn-files.kimovil.com/phone_front/0007/94/thumb_693379_phone_front_big.jpg',
      'name': 'Redmi Note 12',
      'price': 149.99,
    },
    {
      'id': 'prod2',
      'image':
          'https://cdn-files.kimovil.com/default/0007/94/thumb_693382_default_big.jpg',
      'name': 'POCO X5 Pro',
      'price': 199.99,
    },
    {
      'id': 'prod3',
      'image':
          'https://cdn-files.kimovil.com/default/0007/93/thumb_692719_default_big.jpg',
      'name': 'Motorola Edge 40',
      'price': 239.00,
    },
    {
      'id': 'prod4',
      'image':
          'https://cdn-files.kimovil.com/default/0008/33/thumb_732955_default_big.jpg',
      'name': 'Samsung Galaxy A54',
      'price': 329.00,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProductDetailPage(product: product),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: product['id'],
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        product['image'],
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(child: Icon(Icons.broken_image));
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${product['price']}',
                  style: const TextStyle(color: Colors.cyan),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
