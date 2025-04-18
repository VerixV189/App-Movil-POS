import 'package:flutter/material.dart';

class ImageModalViewer extends StatelessWidget {
  final String imageUrl;

  const ImageModalViewer({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black.withOpacity(0.85),
      insetPadding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: InteractiveViewer(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
              errorBuilder:
                  (context, error, stackTrace) =>
                      const Center(child: Icon(Icons.broken_image, size: 80)),
            ),
          ),
        ),
      ),
    );
  }
}
