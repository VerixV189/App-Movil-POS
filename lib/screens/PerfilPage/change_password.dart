import 'package:flutter/material.dart';

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
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              print("cambie de contrasenia");
              // TODO: Llamar al servicio de cambio de contraseña
              Navigator.pop(context);
            }
          },
          child: const Text("Cambiar Contraseña"),
        ),
      ],
    );
  }
}
