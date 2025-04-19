import 'dart:convert';
import 'package:flutter/widgets.dart';
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

    // print("Data recibida: ${json.encode(data)}");
    // return data; // Retorna los datos si la respuesta fue exitosa
    // const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    // final prettyString = encoder.convert(data);
    // print("📦 Data recibida:\n$prettyString");
     Utils.printPrettyJson(data);
   // print("Data recibida: ${json.encode(data)}");
    return data; // Retorna los datos si la respuesta fue exitosa

    
  }

  static Future<List<dynamic>> handleListResponse(
    http.Response response,
  ) async {
    final data = json.decode(response.body);

    if (!Response.ok(response.statusCode)) {
      final Map<String, dynamic> errorData =
          data is Map<String, dynamic> ? data : {};
      throw BackendException(
        message: errorData["message"] ?? "Error en la solicitud",
        error: errorData["error"] ?? "Código Desconocido",
        fecha: errorData["fecha"] ?? DateTime.now().toIso8601String(),
      );
    }

    return data;
  }

  static void printPrettyJson(Map<String, dynamic> data) {
    const tag = "📦 Data recibida:";
    final encoder = const JsonEncoder.withIndent("  ");
    final jsonString = encoder.convert(data);
    final lines = jsonString.split('\n');

    print(tag);
    for (var line in lines) {
      debugPrint(line); // 👈 esto evita que la consola lo recorte
    }
  }
}

class Response {
  static bool ok(int code) {
    return code == 200 || code == 201;
  }
}
