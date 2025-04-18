class BackendException implements Exception {
  final String message;
  final String error;
  final String fecha;

  BackendException({
    required this.message,
    required this.error,
    required this.fecha,
  });

  @override
  String toString() => '$error: $message ($fecha)';
}
