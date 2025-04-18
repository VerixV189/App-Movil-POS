import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/models/AuthRegisterResponseDTO.dart';
import 'package:test/models/AuthUserResponseDTO.dart';
import 'package:test/services/utils.dart';

class AuthService {
  static const String API_URL = "http://192.168.100.4:8000/api"; // Reemplaza con la URL de tu backend
 // static const String API_URL = "http://192.168.100.4:3000/api";
  static const String TOKEN = "token";
  // static const String api_url = "https://backend-tms-qh89.onrender.com/api";

  static Future<AuthUserResponseDTO> login(
    String email,
    String password,
  ) async {
    print(email);
    print(password);

    final response = await http.post(
      Uri.parse('$API_URL/auth/login'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode({'email': email, 'password': password}),
    );

    final data = await Utils.handleResponse(response);
    AuthUserResponseDTO dtoUser = AuthUserResponseDTO.fromJson(data);
    print(dtoUser.message);
    print(dtoUser.usuario);
    print(dtoUser.token);
    storeToken(dtoUser.token);
    return dtoUser;
  }

  //REGISTRO
  static Future<AuthUserRegisterResponseDTO> registrar(
    String email,
    String password,
    String nombre,
  ) async {
    print(email);
    print(password);
    print(nombre);
    final response = await http.post(
      Uri.parse('$API_URL/auth/registrar'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode({
        'email': email,
        'password': password,
        'nombre': nombre,
      }),
    );

    final data = await Utils.handleResponse(response);
    AuthUserRegisterResponseDTO authUserdto = AuthUserRegisterResponseDTO.fromJson(data);

    return authUserdto;
  }

  static Future<void> storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token); // Guarda el token en shared_preferences
  }

  // Método para obtener el token
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(TOKEN);
  }

  static Future<void> revokeToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(TOKEN);
  }
}

class Response {
  static bool ok(int code) {
    return code == 200 || code == 201;
  }
}

// Método para realizar el registro

// Método para almacenar el token
