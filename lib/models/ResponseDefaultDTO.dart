class ResponseDefaulDTO {
  final String message;
  ResponseDefaulDTO({required this.message});

  factory ResponseDefaulDTO.fromJson(Map<String, dynamic> json) {
    return ResponseDefaulDTO(message: json['message']);
  }

  // Método para convertir un UsuarioLoginResponse en un mapa JSON
  Map<String, dynamic> toJson() {
    return {'message': message};
  }
}
