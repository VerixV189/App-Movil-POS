import 'package:flutter/material.dart';


//provider para la categoria seleccionada
class CategoriaSeleccionadaProvider with ChangeNotifier {
  int _categoriaId = 0; // 0 = Todos por defecto

  int get categoriaId => _categoriaId;

  void setCategoria(int id) {
    _categoriaId = id;
    notifyListeners();
  }
}
