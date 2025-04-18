import 'package:test/models/interfaces/IUsuario.dart';

class AuthUserRegisterResponseDTO {
  final Usuario usuario;

  AuthUserRegisterResponseDTO({required this.usuario});

  // Método para convertir el JSON recibido del backend en un objeto LoginResponse
  factory AuthUserRegisterResponseDTO.fromJson(Map<String, dynamic> json) {
    return AuthUserRegisterResponseDTO(
      //conversion de json a objeto usuario
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  // Método para convertir un UsuarioLoginResponse en un mapa JSON
  Map<String, dynamic> toJson() {
    return {'usuario': usuario.toJson()};
  }
}

