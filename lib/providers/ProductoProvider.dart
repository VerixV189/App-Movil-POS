import 'package:flutter/material.dart';
import 'package:test/models/ProductoMostradorDTO.dart';

import 'package:test/services/producto_service.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductoMostradorDTO> _productos = [];

  List<ProductoMostradorDTO> get productos => _productos;

  Future<void> fetchByCategoria(int categoriaId) async {
    if (categoriaId == 0) {
      _productos = await ProductoService.getAllProductoMostradorDTO(); // "Todos"
    } else {
      _productos = await ProductoService.getProductsByCategoryId(categoriaId);
    }
    notifyListeners();
  }
}
