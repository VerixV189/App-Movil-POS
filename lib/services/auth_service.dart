import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String API_URL =
     "http://192.168.100.4:8000/api"; // Reemplaza con la URL de tu backend
  // static const String api_url = "https://backend-tms-qh89.onrender.com/api";

  static Future<Map<String, dynamic>> login(
    String email,
    String password,
  ) async {
    print(email);
    print(password);
    print(API_URL + "/auth/login");
    final response = await http.post(
      Uri.parse(API_URL + "/auth/login"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      print("iniciaste sesion");
      // Si la respuesta es correcta, regresa el token y el usuario
      return json.decode(response.body);
    } else {
      print("nada oe");
      throw Exception('Error en el login');
    }
  }

  //REGISTRO
  static Future<Map<String, dynamic>> signUp(String email, String password) async {
    final response = await http.post(
      Uri.parse('$API_URL/auth/signup'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }
}

  // Método para realizar el registro


// Método para almacenar el token
Future<void> storeToken(String token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_token', token); // Guarda el token en shared_preferences
}

// Método para obtener el token
Future<String?> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_token');
}
