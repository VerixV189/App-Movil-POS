import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/UserProvider.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:test/services/auth_service.dart';

class AppInitializer extends StatefulWidget {
  const AppInitializer({super.key});

  @override
  State<AppInitializer> createState() => _AppInitializerState();
}

class _AppInitializerState extends State<AppInitializer> {
  @override
  void initState() {
    super.initState();
    _inicializar();
  }

  Future<void> _inicializar() async {
    final token = await Storage.getToken();
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (token != null) {
      final usuario = await AuthService.getUserToken(token);
      if (usuario != null) {
        userProvider.setUsuario(usuario);
        Navigator.pushReplacementNamed(context, '/home');
        return;
      }
    }

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
