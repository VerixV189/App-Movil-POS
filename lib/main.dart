import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/auth/login_screen.dart';
import 'package:test/auth/register_screen.dart';
import 'package:test/auth/welcome_screen.dart';
import 'package:test/models/BackendExceptionDTO.dart';
import 'package:test/models/interfaces/IUsuario.dart';
import 'package:test/providers/CategoriaProvider.dart';
import 'package:test/providers/LoadingProvider.dart';
import 'package:test/providers/ProductoProvider.dart';
import 'package:test/providers/UserProvider.dart';
import 'package:test/services/JWT/storage.dart';
import 'package:test/services/auth_service.dart';
import 'package:test/widgets/botton_bart.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await Storage.getToken();

  bool esTokenValido = false;
  Usuario? usuario;

  if (token != null) {
    try {
      esTokenValido = await AuthService.verifyToken(token);
      if (esTokenValido) {
        usuario = await AuthService.getUserToken(token); // obtenés el usuari
      }
    } on BackendException catch (e) {
      esTokenValido = false;
      print("error en la conexion con el backend ${e.message}");
    } catch (e) {
      esTokenValido = false;
      print("error en la conexion con el backend");
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_) => CategoriaSeleccionadaProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final userProvider = UserProvider();
            if (usuario != null) {
              print('usuario autenticado en el main $usuario');
              userProvider.setUsuario(usuario!); // lo inyectás al Provider
            } else {
              print("no existe un usuario autenticado pelau");
            }
            return userProvider;
          },
        ),
      ],
      child: MyApp(initialRoute: esTokenValido ? '/home' : '/'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/': (context) => WelcomePage(),
        '/login': (context) => LoginPageYT(),
        '/signup': (context) => SignupPageYT(),
        '/home': (context) => BottomNavPage(),
      },
    );
  }
}
