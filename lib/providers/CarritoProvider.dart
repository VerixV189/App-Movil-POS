import 'package:flutter/material.dart';
import 'package:test/models/interfaces/Carrito.dart';
import 'package:test/services/carritoService.dart';


class CarritoProvider extends ChangeNotifier {
  Carrito? carrito;

  Future<void> cargarCarrito() async {
    carrito = await CarritoService.obtenerCarrito();
    notifyListeners();
  }

  Future<void> agregarProducto(int productoId) async {
    await CarritoService.agregarProducto(productoId);
    await cargarCarrito(); // Actualiza después de agregar
  }

  Future<void> eliminarProducto(int productoId) async {
    await CarritoService.eliminarProducto(productoId);
    await cargarCarrito();
  }

  Future<void> vaciarCarrito() async {
    
    await CarritoService.vaciarCarrito();
    await cargarCarrito();
  }
}
