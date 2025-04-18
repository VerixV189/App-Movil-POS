import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/UserProvider.dart';
import 'package:test/screens/PerfilPage/change_password.dart';
import 'package:test/screens/PerfilPage/change_profile_photo.dart';
import 'package:test/services/API/server_url.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UserProvider>(context).usuario;
    print("Usuario actual: ${usuario}");
    if (usuario == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Perfil principal
          Column(
            children: [
              CircleAvatar(
                radius: 55,
                //NetworkImage(
                // '{$Server.CLOUDINARY_URL}/${usuario.url_profile!}',
                //)
                backgroundImage:
                    usuario.url_profile != null
                        ? NetworkImage(
                          '${Server.CLOUDINARY_URL}/${usuario.url_profile!}',
                        )
                        : const NetworkImage('https://i.imgur.com/N5uCbDu.png'),
              ),
              const SizedBox(height: 12),
              Text(
                usuario.nombre,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                usuario.rol.nombre ?? 'Rol desconocido',
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
                    builder:
                        (_) => EditUserDialog(
                          name: usuario.nombre,
                          username: usuario.username,
                          email: usuario.email,
                        ),
                  );
                },
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text("Nombre: ${usuario.nombre}"),
                  Text("Username: ${usuario.username}"),
                  Text("Email: ${usuario.email}"),
                  Text("Rol: ${usuario.rol.nombre ?? 'No definido'}"),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Botones para acciones
         ElevatedButton.icon(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const CambiarContraseniaDialog(),
              );
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
              showDialog(
                context: context,
                builder: (_) => const CambiarFotoDialog(),
              );
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
  final String name;
  final String username;
  final String email;

  const EditUserDialog({
    super.key,
    required this.name,
    required this.username,
    required this.email,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final usernameController = TextEditingController(text: username);
    final emailController = TextEditingController(text: email);

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
            // Guardar los cambios
            Navigator.pop(context);
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
