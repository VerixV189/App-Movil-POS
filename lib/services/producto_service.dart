import 'dart:convert';
import 'package:test/models/ProductoMostradorDTO.dart';
import 'package:test/models/interfaces/IProducto.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:http/http.dart' as http;
import 'package:test/services/Utils/utils.dart';

class ProductoService {
  //quizas despues paginado
  static Future<List<ProductoMostradorDTO>> getAllProductoMostradorDTO() async {
    final token = await Storage.getToken();
    final response = await http.get(
      Uri.parse('${Server.API_URL}/productos/list'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    //en json puro

    // Suponiendo que `data` es una lista de mapas:
    final List<dynamic> data = await Utils.handleListResponse(response);
    return data.map((json) => ProductoMostradorDTO.fromJson(json)).toList();
  }

  static Future<List<ProductoMostradorDTO>> getProductsByCategoryId(
    int id,
  ) async {
    final token = await Storage.getToken();
    final response = await http.get(
      Uri.parse('${Server.API_URL}/productos/categoria/$id/list'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    //en json puro

    final List<dynamic> data = await Utils.handleListResponse(response);
    return data.map((json) => ProductoMostradorDTO.fromJson(json)).toList();
  }

  static Future<Producto> getProductoCompleto(int id) async {
    try {
      final token = await Storage.getToken();
      final response = await http.get(
        Uri.parse('${Server.API_URL}/productos/$id/get-all-data'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      );

      // Suponiendo que `data` es una lista de mapas:
      final data = await Utils.handleResponse(response);
      final productoData = Map<String, dynamic>.from(data["producto"]);
      productoData["estadisticas"] = data["estadisticas"] ?? {};
      return Producto.fromJson(productoData);

    } catch (e, stack) {
      print("❌ Error en getProductoCompleto: $e");
      print("📌 Stacktrace: $stack");
      rethrow;
    }
  }
}
