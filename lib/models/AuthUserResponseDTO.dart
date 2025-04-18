import 'package:test/models/interfaces/IUsuario.dart';

class AuthUserResponseDTO {
  final String message;
  final String token;
  final Usuario usuario;

  AuthUserResponseDTO({
    required this.message,
    required this.token,
    required this.usuario,
  });

  // Método para convertir el JSON recibido del backend en un objeto LoginResponse
  factory AuthUserResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthUserResponseDTO(
      message: json['message'],
      token: json['token'],
      //conversion de json a objeto usuario
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  // Método para convertir un UsuarioLoginResponse en un mapa JSON
  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token, 'usuario': usuario.toJson()};
  }
}




