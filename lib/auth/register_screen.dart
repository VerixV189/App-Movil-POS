import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/LoadingOverlay.dart';

import 'package:test/providers/LoadingProvider.dart';
import 'package:test/services/auth_service.dart';

class SignupPageYT extends StatefulWidget {
  @override
  SigunpPageYTState createState() => SigunpPageYTState();
}

class SigunpPageYTState extends State<SignupPageYT> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void _do_something() {
    print("El mejor metodo del mundo");
     print("Email: ${emailController.text}");
    print("Password: ${passwordController.text}");
    print("nombre: ${nameController.text}");
  }

  // Método de registro
  Future<void> _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        Provider.of<LoadingProvider>(context, listen: false).startLoading();
        // Imprimir los valores de email y password antes de enviar la solicitud
        print("Email: ${emailController.text}");
        print("Password: ${passwordController.text}");
        print("nombre: ${nameController.text}");

        // Realiza el registro con los datos del formulario
        final registerResponseDTO = await AuthService.registrar(
          emailController.text,
          passwordController.text,
          nameController.text,
        );

        Provider.of<LoadingProvider>(context, listen: false).stopLoading();
       // if (registerResponseDTO != null) {
          // Si el registro es exitoso, navega al login
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Registro exitoso, por favor inicia sesión"),
            ),
          );
          // Redirige al login
          // Redirige al login y pasa el email y password
          Navigator.pushReplacementNamed(
            context,
            '/login',
            arguments: {
              'email': emailController.text,
              'password': passwordController.text,
            },
          );
       // }
      } catch (error) {
        Provider.of<LoadingProvider>(context, listen: false).stopLoading();
        // Si ocurre un error en el registro, muestra un mensaje
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error al registrar: $error')));
      }
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
        // Usamos un Stack para apilar el formulario y el overlay de carga
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              double screenHeight = constraints.maxHeight;
              double screenWidth = constraints.maxWidth;

              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  height: screenHeight - 50,
                  width: double.infinity,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            FadeInUp(
                              duration: Duration(milliseconds: 1000),
                              child: Text(
                                "Registro",
                                style: TextStyle(
                                  fontSize:
                                      screenWidth * 0.08, // Ajuste dinámico
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),
                            FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: Text(
                                "Create una cuenta!, es Gratis",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.05,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: makeInput(
                                label: "Nombre",
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please ingrese su nombre';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1300),
                              child: makeInput(
                                label: "Email",
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor ingrese un email';
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
                              duration: Duration(milliseconds: 1400),
                              child: makePasswordInput(
                                label: "Password",
                                controller: passwordController,
                                obscureText: _obscureText,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a password';
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
                        FadeInUp(
                          duration: Duration(milliseconds: 1600),
                          child: Container(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              ),
                            ),
                            child: MaterialButton(
                              minWidth: double.infinity,
                              height: screenHeight * 0.08, // Ajuste dinámico
                              onPressed: _register,
                              color: Colors.greenAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.05,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1700),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Ya tiene una cuenta?"),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, '/login');
                                },
                                child: Text(
                                  " Login",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: screenWidth * 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // Mostrar el LoadingOverlay cuando esté cargando
          Provider.of<LoadingProvider>(context).isLoading
              ? LoadingOverlay()
              : SizedBox.shrink(),
        ],
      ),
    );
  }

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
          ),
          validator: validator,
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
