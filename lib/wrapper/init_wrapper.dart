import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/providers/UserProvider.dart';

class InitWrapper extends StatefulWidget {
  const InitWrapper({super.key});

  @override
  State<InitWrapper> createState() => _InitWrapperState();
}

class _InitWrapperState extends State<InitWrapper> {
  @override
  void initState() {
    super.initState();
    _initApp();
  }

  Future<void> _initApp() async {
    final token = await Storage.getToken();

    if (token != null) {
      try {
        final isValid = await AuthService.verifyToken(token);
        if (isValid) {
          final user = await AuthService.getUserToken(token);
          Provider.of<UserProvider>(context, listen: false).setUsuario(user);
          Navigator.pushReplacementNamed(context, '/home');
          return;
        }
      } catch (e) {
        print("❌ Error al verificar token: $e");
      }
    }

    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
