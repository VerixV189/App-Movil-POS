import 'package:flutter/material.dart';
import 'package:test/services/API/server_url.dart';

//para el card del comentario
class CommentCard extends StatelessWidget {
  final String username;
  final String date;
  final String content;
  final int stars;
  final String? urlProfile; // Nueva imagen de perfil
  final bool isCurrentUser;
  final void Function()? onEdit;
  final void Function()? onDelete;
  const CommentCard({
    Key? key,
    required this.username,
    required this.date,
    required this.content,
    required this.stars,
    required this.isCurrentUser,
    this.onEdit,
    this.onDelete,
    this.urlProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 2,
      child: ListTile(
        // leading: CircleAvatar(
        //   backgroundColor: isCurrentUser ? const Color.fromRGBO(0, 188, 212, 1) : Colors.grey.shade400,
        //   child: Text(username[0].toUpperCase()),
        // ),
       leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage:
              urlProfile != null
                  ? NetworkImage(
                    '${Server.CLOUDINARY_URL}/${urlProfile!}',
                  )
                  : const AssetImage('assets/default_profile.jpg')
                      ,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                username,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            const SizedBox(width: 8), // espaciado mínimo
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
                    if (value == 'edit') onEdit?.call();
                    if (value == 'delete') onDelete?.call();
                  },
                  itemBuilder:
                      (_) => const [
                        PopupMenuItem(value: 'edit', child: Text('Editar')),
                        PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                      ],
                )
                : null,
      ),
    );
  }



}
