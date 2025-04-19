import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:test/models/BackendExceptionDTO.dart';
import 'package:test/providers/UserProvider.dart';

import 'package:test/services/usuario_service.dart'; // tu servicio que sube la imagen

class CambiarFotoDialog extends StatefulWidget {
  const CambiarFotoDialog({super.key});

  @override
  State<CambiarFotoDialog> createState() => _CambiarFotoDialogState();
}

class _CambiarFotoDialogState extends State<CambiarFotoDialog> {
  File? _imagenSeleccionada;
  bool _isLoading = false;

//para abrir el dialogo de seleccion de imagenes
  Future<void> _seleccionarImagen() async {
    try {
      final picker = ImagePicker();
      final XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
        maxWidth: 1024,
        maxHeight: 1024,
      );
//validacion por si no se selecciono una imagen
      if (imageFile == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("No se seleccionó ninguna imagen.")),
          );
        }
        return;
      }

      final File file = File(imageFile.path);
      final exists = await file.exists();

      if (!exists) {
        if (context.mounted) {
            print("me dispare en el !exists");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("La imagen no se pudo cargar.")),
          );
        }
        return;
      }

      //renderizar la vista
      setState(() {
        _imagenSeleccionada = file;
      });
    } catch (e) {
      debugPrint("Error al seleccionar imagen: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Ocurrió un error al abrir la galería")),
        );
      }
    }
  }

//subir la imagen y llamada al backend
  Future<void> _subirImagen() async {
    if (_imagenSeleccionada == null) return;


   
    setState(() => _isLoading = true);

    try {
      final dto = await UsuarioService.actualizarFotoPerfil(
        _imagenSeleccionada!,
      );

      //repuestas del back en el objeto dto
      if (dto.usuario != null && context.mounted) {
        print(
          "Respuesta DTO: ${dto.message} | usuario: ${dto.usuario?.url_profile}",
        );
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUsuario(dto.usuario!);
        print("Nueva URL: ${dto.usuario?.url_profile}");
        final usuario = context.watch<UserProvider>().usuario;
      }
      if (context.mounted) {
        
        
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(dto.message)));

        // await Future.delayed(const Duration(milliseconds: 300));
        // if (context.mounted) Navigator.pop(context);
      }
    } on BackendException catch (e) {
        // Captura los errores de tu backend específicamente
        
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(e.message)));
          print("me dispare en el backend excepction");
        }
    } catch (e) {
       
      if (context.mounted) {

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("E Imagen Subida")),
        );
      }
    } finally {
      setState(() => _isLoading = false);
      Navigator.pop(context);
    }
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
            label: Text(
              _imagenSeleccionada != null
                  ? "Imagen seleccionada"
                  : "Seleccionar Imagen",
            ),
          ),
          const SizedBox(height: 8),
          if (_imagenSeleccionada != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(_imagenSeleccionada!, height: 120),
            ),
          const SizedBox(height: 8),
          const Text("Formatos: PNG, JPG, WebP, SVG"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _subirImagen,
          child:
              _isLoading
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : const Text("Guardar"),
        ),
      ],
    );
  }
}
