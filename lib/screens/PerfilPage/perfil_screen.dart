import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/BackendExceptionDTO.dart';
import 'package:test/providers/UserProvider.dart';
import 'package:test/screens/PerfilPage/change_password.dart';
import 'package:test/screens/PerfilPage/change_profile_photo.dart';
import 'package:test/screens/PerfilPage/logout_buttom.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/services/usuario_service.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<UserProvider>(context).usuario;
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
                        : const NetworkImage('https://cdn.vectorstock.com/i/500p/20/76/man-avatar-profile-vector-21372076.jpg'),
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
                usuario.rol?.nombre ?? 'Rol desconocido',
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
                  Text("Rol: ${usuario.rol?.nombre ?? 'No definido'}"),
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
               backgroundColor: const Color.fromARGB(255, 76, 175, 175), // Fondo
              foregroundColor: Colors.white,  
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
              backgroundColor: Colors.cyan, // Color de fondo
              foregroundColor: Colors.white, // Color de texto e ícono
              minimumSize: const Size.fromHeight(50),
            ),
          ),
          const SizedBox(height: 13),
          //para el logout
          ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text("Cerrar Sesión"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const LogoutDialog(),
              );
            },
          ),

        ],
      ),
    );
  }
}


class EditUserDialog extends StatefulWidget {
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
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _usernameController;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _usernameController = TextEditingController(text: widget.username);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _guardarCambios() async {
    

    if (_formKey.currentState!.validate()) {
      // Simulamos un DTO
      final data = {
        "nombre": _nameController.text,
        "username": _usernameController.text,
        "email": _emailController.text,
        // "rol_id": rolId
      };

      try {
        // Llama al backend para actualizar
        final actualizado = await UsuarioService.actualizarDatosPersonales(data);

        // Actualiza el usuario en Provider
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUsuario(actualizado);

        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Perfil actualizado correctamente")),
          );
        }
      } on BackendException catch (e) {
        // Captura los errores de tu backend específicamente
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.message)));
        }
      } catch (e) {
        // Captura errores generales o inesperados
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error inesperado al editar los datos del perfil"),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Editar Información"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
              validator:
                  (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Campo obligatorio'
                          : null,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
              validator:
                  (value) =>
                      value == null || value.trim().isEmpty
                          ? 'Campo obligatorio'
                          : null,
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator:
                  (value) =>
                      value == null || !value.contains('@')
                          ? 'Email inválido'
                          : null,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _guardarCambios,
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
