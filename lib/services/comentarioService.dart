import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/services/API/server_url.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:test/services/Utils/utils.dart';

class ComentarioService {
  static Future<void> crearComentario({
    required int productoId,
    required int puntuacion,
    required String descripcion,
  }) async {
    print(productoId);
    print(puntuacion);
    print(descripcion);
    final token = await Storage.getToken();
    final response = await http.post(
      Uri.parse('${Server.API_URL}/comentarios/$productoId/create'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"puntuacion": puntuacion, "descripcion": descripcion}),
    );

    await Utils.handleResponse(response);
  }

  static Future<void> editarComentario({
    required int comentarioId,
    required int puntuacion,
    required String descripcion,
  }) async {
    final token = await Storage.getToken();
    final response = await http.put(
      Uri.parse('${Server.API_URL}/comentarios/$comentarioId/update'),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({"puntuacion": puntuacion, "descripcion": descripcion}),
    );

    await Utils.handleResponse(response);
  }

  static Future<void> eliminarComentario(int comentarioId) async {
    final token = await Storage.getToken();
    final response = await http.delete(
      Uri.parse('${Server.API_URL}/comentarios/$comentarioId/delete'),
      headers: {"Authorization": "Bearer $token"},
    );

    await Utils.handleResponse(response);
  }
}
