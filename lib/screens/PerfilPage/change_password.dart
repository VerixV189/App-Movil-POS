import 'package:flutter/material.dart';
import 'package:test/models/BackendExceptionDTO.dart';
import 'package:test/models/ResponseDefaultDTO.dart';
import 'package:test/services/usuario_service.dart';


class CambiarContraseniaDialog extends StatefulWidget {
  const CambiarContraseniaDialog({super.key});

  @override
  State<CambiarContraseniaDialog> createState() =>
      _CambiarContraseniaDialogState();
}

class _CambiarContraseniaDialogState extends State<CambiarContraseniaDialog> {
  final _formKey = GlobalKey<FormState>();
  final _actualController = TextEditingController();
  final _nuevaController = TextEditingController();
  bool _obscureActual = true;
  bool _obscureNueva = true;
  bool _isLoading = false;

  Future<void> _cambiarPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      //mando esto
      final respuesta = await UsuarioService.actualizarPassword({
        "anterior_password": _actualController.text.trim(),
        "nueva_password": _nuevaController.text.trim(),
      });

      if (context.mounted) {
        Navigator.pop(context); // cerrar modal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(respuesta.message ?? "Contraseña cambiada")),
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
            content: Text("Error inesperado al cambiar la contraseña"),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cambiar tu contraseña"),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _actualController,
              obscureText: _obscureActual,
              decoration: InputDecoration(
                labelText: 'Contraseña Actual',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureActual ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed:
                      () => setState(() => _obscureActual = !_obscureActual),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 4) {
                  return 'Debe tener al menos 4 caracteres';
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _nuevaController,
              obscureText: _obscureNueva,
              decoration: InputDecoration(
                labelText: 'Nueva Contraseña',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNueva ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed:
                      () => setState(() => _obscureNueva = !_obscureNueva),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 4) {
                  return 'Debe tener al menos 4 caracteres';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _cambiarPassword,
          child:
              _isLoading
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text("Cambiar Contraseña"),
        ),
      ],
    );
  }
}
