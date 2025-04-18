import 'package:flutter/material.dart';
import 'package:test/widgets/reviews/rating_bar.dart';


// el resumen de validaciones  de 5 estrellas cuantas son buenas y asi, un PA para las valoraciones
class RatingSummary extends StatelessWidget {
  final double averageRating;
  final int totalRatings;
  final Map<int, int> ratingDistribution; // {5: 1200, 4: 200, ...}

  const RatingSummary({
    Key? key,
    required this.averageRating,
    required this.totalRatings,
    required this.ratingDistribution,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 16),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Sección de promedio
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  averageRating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < averageRating.round()
                          ? Icons.star
                          : Icons.star_border,
                      color: Colors.amber,
                    );
                  }),
                ),
                const SizedBox(height: 4),
                Text(
                  "$totalRatings valoraciones",
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(width: 24),
            // Sección de barras
            Expanded(
              child: Column(
                children: List.generate(5, (index) {
                  int stars = 5 - index;
                  int count = ratingDistribution[stars] ?? 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: RatingBar(
                      starLevel: stars,
                      count: count,
                      total: totalRatings,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
