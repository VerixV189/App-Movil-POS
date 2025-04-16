import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/LoadingProvider.dart';
//creo que es la clase para mostrar el componente cargando
const double SIZE_DEFAULT = 100;
class LoadingOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoadingProvider>(
      builder: (context, loadingProvider, child) {
        // Solo muestra el indicador de carga si _isLoading es true
        if (loadingProvider.isLoading) {
          return Center(
            child: LoadingAnimationWidget.hexagonDots(
              color: const Color(0xFFFF0084),
              size: SIZE_DEFAULT
            ),
          );
        }
        return SizedBox.shrink(); // No muestra nada cuando no está cargando
      },
    );
  }
}
