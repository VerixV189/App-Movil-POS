import 'package:flutter/material.dart';

class CambiarFotoDialog extends StatefulWidget {
  const CambiarFotoDialog({super.key});

  @override
  State<CambiarFotoDialog> createState() => _CambiarFotoDialogState();
}

class _CambiarFotoDialogState extends State<CambiarFotoDialog> {
  String? fileName;

  Future<void> _seleccionarImagen() async {
    // TODO: usar ImagePicker o FilePicker para móvil
    print('Funcionalidad pendiente de seleccionar archivo');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Subir Nueva Foto de Perfil"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton.icon(
            onPressed: _seleccionarImagen,
            icon: const Icon(Icons.upload_file),
            label: Text(fileName ?? "Seleccionar Imagen"),
          ),
          const SizedBox(height: 8),
          const Text("Formatos permitidos: PNG, JPG, WebP, SVG"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            // TODO: subir imagen
            Navigator.pop(context);
          },
          child: const Text("Guardar"),
        ),
      ],
    );
  }
}
