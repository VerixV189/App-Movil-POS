import 'package:flutter/material.dart';

//para el card del comentario
class CommentCard extends StatelessWidget {
  final String username;
  final String date;
  final String content;
  final int stars;
  final bool isCurrentUser;

  const CommentCard({
    Key? key,
    required this.username,
    required this.date,
    required this.content,
    required this.stars,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: isCurrentUser ? Colors.cyan : Colors.grey.shade400,
          child: Text(username[0].toUpperCase()),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(username),
            Text(
              date,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < stars ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 18,
                );
              }),
            ),
            const SizedBox(height: 6),
            Text(content),
          ],
        ),
        trailing:
            isCurrentUser
                ? PopupMenuButton<String>(
                  onSelected: (value) {
                    // Aquí luego va la lógica de editar o eliminar
                  },
                  itemBuilder:
                      (context) => const [
                        PopupMenuItem(value: 'edit', child: Text('Editar')),
                        PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                      ],
                )
                : null,
      ),
    );
  }
}
