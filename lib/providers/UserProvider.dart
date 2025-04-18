import 'package:flutter/material.dart';
import 'package:test/models/interfaces/IUsuario.dart';

class UserProvider with ChangeNotifier {
  Usuario? _usuario;

  Usuario? get usuario => _usuario;

  void setUsuario(Usuario usuario) {
    _usuario = usuario;
    notifyListeners();
  }

  void clearUsuario() {
    _usuario = null;
    notifyListeners();
  }
}
