import 'package:flutter/material.dart';

class PerfilScreen extends StatelessWidget {
  final Map<String, String> user = {
    'name': 'Fernando Padilla Lopez',
    'username': '6-fercho-9',
    'email': 'fernando@gmail.com',
    'role': 'ADMINISTRADOR',
    'location': 'Santa Cruz/Bolivia',
    'profilePic': 'https://i.imgur.com/N5uCbDu.png',
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Perfil principal
          Column(
            children: [
              CircleAvatar(
                radius: 55,
                backgroundImage: NetworkImage(user['profilePic']!),
              ),
              const SizedBox(height: 12),
              Text(
                user['name']!,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(user['role']!, style: const TextStyle(color: Colors.grey)),
              Text(
                user['location']!,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Información personal
          Card(
            child: ListTile(
              title: const Text(
                'Información Personal',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => EditUserDialog(user: user),
                  );
                },
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text("Nombre: ${user['name']}"),
                  Text("Username: ${user['username']}"),
                  Text("Email: ${user['email']}"),
                  Text("Rol: ${user['role']}"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Botones para acciones
          ElevatedButton.icon(
            onPressed: () {
              // Cambiar contraseña
            },
            icon: const Icon(Icons.lock_reset),
            label: const Text("Cambiar Contraseña"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () {
              // Cambiar foto de perfil
            },
            icon: const Icon(Icons.image),
            label: const Text("Cambiar Foto de Perfil"),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
          ),
        ],
      ),
    );
  }
}

class EditUserDialog extends StatelessWidget {
  final Map<String, String> user;

  const EditUserDialog({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: user['name']);
    final usernameController = TextEditingController(text: user['username']);
    final emailController = TextEditingController(text: user['email']);

    return AlertDialog(
      title: const Text("Editar Información"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            // Guardar la edición
            Navigator.pop(context);
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
