import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test/models/BackendExceptionDTO.dart';


class Utils {
  static Future<Map<String, dynamic>> handleResponse(
    http.Response response,
  ) async {
    // Obtiene los datos de la respuesta
    final Map<String, dynamic> data = json.decode(response.body);

    // Si la respuesta no es 2xx, lanza una excepción con los detalles
    if (!Response.ok(response.statusCode)) {
      throw BackendException(
        message: data["message"] ?? "Error en la solicitud",
        error: data["error"] ?? "Código Desconocido",
        fecha: data["fecha"] ?? DateTime.now().toIso8601String(),
      );
    }

    print("Data recibida: ${json.encode(data)}");
    return data; // Retorna los datos si la respuesta fue exitosa
  }
  

}

class Response {
  static bool ok(int code) {
    return code == 200 || code == 201;
  }
}

