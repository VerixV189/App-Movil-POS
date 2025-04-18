import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/models/AuthRegisterResponseDTO.dart';
import 'package:test/models/AuthUserResponseDTO.dart';
import 'package:test/providers/UserProvider.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:test/services/Utils/utils.dart';

class AuthService {
  // static const String api_url = "https://backend-tms-qh89.onrender.com/api";

  static Future<AuthUserResponseDTO> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    print(email);
    print(password);
    final response = await http.post(
      Uri.parse('${Server.API_URL}/auth/login'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: json.encode({'email': email, 'password': password}),
    );

    final data = await Utils.handleResponse(response);

    AuthUserResponseDTO dtoUser = AuthUserResponseDTO.fromJson(data);

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUsuario(dtoUser.usuario);
    print(dtoUser.message);
    print(dtoUser.usuario);
    print(dtoUser.token);
    Storage.storeToken(dtoUser.token);
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
      Uri.parse('${Server.API_URL}/auth/registrar'),
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
    AuthUserRegisterResponseDTO authUserdto =
        AuthUserRegisterResponseDTO.fromJson(data);

    return authUserdto;
  }

  static Future<bool> verifyToken(String token) async {
    
      final response = await http.get(
        Uri.parse('${Server.API_URL}/auth/me'),
        headers: {
          "Authorization":"Bearer $token"
        },
      );

      if (Response.ok(response.statusCode)) {
        return true;
      }
      
      return false;
    
  }
}

// Método para realizar el registro

// Método para almacenar el token
