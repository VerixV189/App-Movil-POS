import 'dart:convert';
import 'package:test/models/ProductoMostradorDTO.dart';
import 'package:test/models/interfaces/ICategoria.dart';
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
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => ProductoMostradorDTO.fromJson(json)).toList();
  }

  static Future<List<ProductoMostradorDTO>> getProductsByCategoryId(int id) async {
    final token = await Storage.getToken();
    final response = await http.get(
      Uri.parse('${Server.API_URL}/productos/categoria/$id/list'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    //en json puro

    // Suponiendo que `data` es una lista de mapas:
    final List<dynamic> data = json.decode(response.body);
    return data.map((json) => ProductoMostradorDTO.fromJson(json)).toList();
  }
}
