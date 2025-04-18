import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/models/ResponseDefaultDTO.dart';
// import 'package:provider/provider.dart';
import 'package:test/models/interfaces/IUsuario.dart';
// import 'package:test/providers/UserProvider.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:test/services/Utils/utils.dart';

class UsuarioService {

//en data ya viene los datos a actualizar
static Future<Usuario> actualizarDatosPersonales(Map<String, dynamic> data) async {
    final token = await Storage.getToken();
    print(data);
    final response = await http.put(
      Uri.parse('${Server.API_URL}/usuarios/edit'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    
      body: json.encode(data),
    );

    final jsonData = await Utils.handleResponse(response);

    Usuario authUserdto = Usuario.fromJson(jsonData['usuario']);

    //actualizamos el usuario autenticado de la pagina
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // userProvider.setUsuario(authUserdto);

    //convertimos a json para una respuesta
    return authUserdto; 
  }

  //en data ya viene los datos a actualizar
  static Future<ResponseDefaulDTO> actualizarPassword(Map<String, dynamic> data) async {
    final token = await Storage.getToken();
    print(data);
    final response = await http.put(
      Uri.parse('${Server.API_URL}/usuarios/change-password'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    
      body: json.encode(data),
    );

    final jsonData = await Utils.handleResponse(response);

    ResponseDefaulDTO responseDefault = ResponseDefaulDTO.fromJson(jsonData);

    //actualizamos el usuario autenticado de la pagina
    // final userProvider = Provider.of<UserProvider>(context, listen: false);
    // userProvider.setUsuario(authUserdto);

    //convertimos a json para una respuesta
    return responseDefault; 
  }
}

