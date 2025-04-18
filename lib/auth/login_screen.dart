import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/LoadingOverlay.dart';
import 'package:test/providers/LoadingProvider.dart';
import 'package:test/services/auth_service.dart'; // Importa tu servicio de autenticación
//import 'package:loading_animation_widget/loading_animation_widget.dart'; // Cargar la librería para la animación de carga

class LoginPageYT extends StatefulWidget {
  @override
  LoginPageYTState createState() => LoginPageYTState();
}

class LoginPageYTState extends State<LoginPageYT> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //bool _isLoading = false; // Variable para controlar si se está cargando
  bool _obscureText = true;


   @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Acceder a los datos pasados desde la pantalla de registro
    final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arguments != null) {
      // Si hay datos, pre-cargar los campos de texto
      emailController.text = arguments['email'] ?? '';
      passwordController.text = arguments['password'] ?? '';
    }
  }

  // Método de login
  Future<void> _login() async {
    // Verificar si el formulario es válido antes de continuar
    if (_formKey.currentState?.validate() ?? false) {
      // setState(() {
      //   _isLoading = true; // Inicia la animación de carga
      // });
      Provider.of<LoadingProvider>(context, listen: false).startLoading();
      // Imprimir los valores de email y password antes de enviar la solicitud
      print("Email: ${emailController.text}");
      print("Password: ${passwordController.text}");

      try {
        // Realizamos el login con las credenciales introducidas
        final loginResponseDTO = await AuthService.login(
          emailController.text,
          passwordController.text,
        );

        // Detenemos la animación de carga después de recibir la respuesta
        Provider.of<LoadingProvider>(context, listen: false).stopLoading();

        //if (loginResponseDTO != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${loginResponseDTO.message}")),
          );

          // Si el login es exitoso, navega a la pantalla principal
          Navigator.pushReplacementNamed(context, '/home');
      //  }
      } catch (error) {
        // Detener la animación de carga y mostrar el error
        // setState(() {
        //   _isLoading = false;
        // });
        Provider.of<LoadingProvider>(context, listen: false).stopLoading();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $error')),
        );
      }
    } else {
      Provider.of<LoadingProvider>(context, listen: false).stopLoading();
      // Si el formulario no es válido, mostramos un mensaje
      print("Formulario no válido");
      print(emailController.text); // Imprime el valor de email
      print(passwordController.text); // Imprime el valor de la contraseña

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Por favor, corrija los errores antes de continuar.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
        ),
      ),
      body: Stack(
        children: <Widget>[
          // El contenido de la pantalla (formulario de login)
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          FadeInUp(
                            duration: Duration(milliseconds: 1000),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FadeInUp(
                            duration: Duration(milliseconds: 1200),
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              FadeInUp(
                                duration: Duration(milliseconds: 1200),
                                //input de email
                                child: makeInput(
                                  label: "Email",
                                  controller:
                                      emailController, // Asegúrate de que el controlador esté vinculado
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingrese un email!';
                                    }
                                    bool emailValid = RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                    ).hasMatch(value);
                                    if (!emailValid) {
                                      return 'Por favor ingrese un email valido';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              FadeInUp(
                                duration: Duration(milliseconds: 1300),
                                child: makePasswordInput(
                                  label: "Password",
                                  controller:
                                      passwordController, // Asegúrate de que el controlador esté vinculado
                                  obscureText: _obscureText,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Por favor ingrese una contraseña!';
                                    }
                                    if (value.length < 4) {
                                      return 'La contraseña debe ser de al menos 4 caracteres';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1400),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          child: Container(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: Colors.black),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: 60,
                              onPressed:
                                  _login, // Llamada a la función de login
                              color: Colors.greenAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("No tienes una cuenta?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Registrate ahora!",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                FadeInUp(
                  duration: Duration(milliseconds: 1200),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/background.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // El indicador de carga global (se muestra cuando el estado de carga es true)
          // if (_isLoading)
          //   Center(
          //     child: LoadingAnimationWidget.hexagonDots(
          //       color: const Color(0xFFFF0084),
          //       size: 100,
          //     ),
          //   ),
          LoadingOverlay(),
        ],
      ),
    );
  }


  // Método para mostrar el input de contraseña con un ícono de ver/ocultar
  //creo que es un componente de password input
  Widget makePasswordInput({
    label,
    obscureText = false,
    validator,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  _obscureText =
                      !_obscureText; // Cambiar el valor de la visibilidad
                });
              },
            ),
          ),
          validator: validator,
        ),
        SizedBox(height: 30),
      ],
    );
  }

  Widget makeInput({
    label,
    obscureText = false,
    validator,
    TextEditingController? controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller, // Asignamos el controlador aquí
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
          validator: validator,
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
