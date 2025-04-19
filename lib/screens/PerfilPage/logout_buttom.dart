import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/UserProvider.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/services/JWT/storage.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cerrar Sesión"),
      content: const Text("¿Estás seguro de que deseas cerrar sesión?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          icon: const Icon(Icons.logout),
          label: const Text("Sí, cerrar"),
          onPressed: () async {
            try {
              await AuthService.logout(); // Llama al logout del backend
              // Limpiar usuario en Provider
              final userProvider = Provider.of<UserProvider>(
                context,
                listen: false,
              );
              userProvider.clearUsuario();

              if (context.mounted) {
                Navigator.of(
                  context,
                ).pushNamedAndRemoveUntil('/', (_) => false);
              }
            } catch (e) {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Error al cerrar sesión: $e")),
                );
              }
            }
          },
        ),
      ],
    );
  }
}
