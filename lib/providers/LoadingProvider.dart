import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void startLoading() {
    _isLoading = true;
    notifyListeners(); // Notifica a todos los widgets que están escuchando este cambio.
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners(); // Notifica que la carga ha terminado.
  }
}
