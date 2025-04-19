import 'package:test/models/interfaces/IUsuario.dart';

class ResponseDefaulDTO {
  final String message;
  final Usuario? usuario;
  ResponseDefaulDTO({required this.message,this.usuario});

  factory ResponseDefaulDTO.fromJson(Map<String, dynamic> json) {
      final usuarioJson = json['usuario'];
    return ResponseDefaulDTO(
       message: json['message'] ?? "Sin mensaje",
      usuario:
          (usuarioJson != null && usuarioJson is Map<String, dynamic>)
              ? Usuario.fromJson(usuarioJson)
              : null,
    );
  }

  // Método para convertir un UsuarioLoginResponse en un mapa JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {'message': message};

    
    if (usuario != null) {
      data['usuario'] =
          usuario!.toJson(); // asumiendo que Usuario tiene .toJson()
    }
    return data;
  }
}
