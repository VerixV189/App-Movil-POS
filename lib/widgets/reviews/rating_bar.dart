import 'package:flutter/material.dart';

// creo que esto simula la barra horizontal
class RatingBar extends StatelessWidget {
  final int starLevel; // Por ejemplo: 5, 4, 3...
  final int count; // Cantidad de votos con ese nivel
  final int total; // Total de votos para sacar el porcentaje

  const RatingBar({
    Key? key,
    required this.starLevel,
    required this.count,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percentage = total > 0 ? count / total : 0;

    return Row(
      children: [
        Text('$starLevel', style: const TextStyle(fontSize: 14)),
        const SizedBox(width: 4),
        const Icon(Icons.star, size: 16, color: Colors.amber),
        const SizedBox(width: 8),
        Expanded(
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey.shade300,
            color: Colors.cyan,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text('$count', style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
