import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/models/interfaces/Carrito.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:test/services/Utils/utils.dart';

class CarritoService {
  static Future<Carrito> obtenerCarrito() async {
    final token = await Storage.getToken();
    final response = await http.get(
      Uri.parse('${Server.API_URL}/carritos/cart-item/list'),
      headers: {'Authorization': 'Bearer $token'},
    );
    final data = await Utils.handleResponse(response);
    return Carrito.fromJson(data);
  }

  static Future<void> agregarProducto(int productoId) async {
    final token = await Storage.getToken();
    final response = await http.post(
      Uri.parse('${Server.API_URL}/carritos/producto/$productoId/add-product'),
      headers: {'Authorization': 'Bearer $token'},
    );
    await Utils.handleResponse(response);
  }

  static Future<void> eliminarProducto(int productoId) async {
    final token = await Storage.getToken();
    final response = await http.delete(
      Uri.parse(
        '${Server.API_URL}/carritos/producto/$productoId/delete-product',
      ),
      headers: {'Authorization': 'Bearer $token'},
    );
    await Utils.handleResponse(response);
  }

  static Future<void> vaciarCarrito() async {
    final token = await Storage.getToken();
    final response = await http.post(
      Uri.parse('${Server.API_URL}/carritos/vaciar-carrito'),
      headers: {'Authorization': 'Bearer $token'},
    );
    await Utils.handleResponse(response);
  }
}
