import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  final List<Map<String, dynamic>> categories = const [
    {'icon': Icons.shopping_bag_outlined, 'label': 'Ropa'},
    {'icon': Icons.chair_outlined, 'label': 'Muebles'},
    {'icon': Icons.camera_alt_outlined, 'label': 'Fotografía'},
    {'icon': Icons.headphones_outlined, 'label': 'Audífonos'},
    {'icon': Icons.directions_car_filled_outlined, 'label': 'Autos'},
    {'icon': Icons.sports_soccer, 'label': 'Deportes'},
    {'icon': Icons.fastfood_outlined, 'label': 'Comida'},
    {'icon': Icons.phone_android, 'label': 'Electrónica'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final cat = categories[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(cat['icon'], size: 32, color: Colors.cyan),
              const SizedBox(height: 4),
              Text(cat['label'], style: const TextStyle(fontSize: 12)),
            ],
          );
        },
      ),
    );
  }
}
