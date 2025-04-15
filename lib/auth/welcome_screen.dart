import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:test/auth/login_screen.dart';
import 'package:test/auth/register_screen.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1000),
                    child: Text(
                      "Bienvenido!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: Text(
                      "Registrate y Se parte de nuestro equipo",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[700], fontSize: 15),
                    ),
                  ),
                ],
              ),
              FadeInUp(
                duration: Duration(milliseconds: 1400),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/Illustration.png'),
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPageYT()),
                        );
                      },
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
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
                  SizedBox(height: 20),
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
                        height: 60,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignupPageYT(),
                            ),
                          );
                        },
                        color: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//supuesto responsive
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:test/auth/login_screen.dart';
// import 'package:test/auth/register_screen.dart';

// class WelcomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double screenHeight = constraints.maxHeight;
//           double screenWidth = constraints.maxWidth;

//           return SafeArea(
//             child: Container(
//               width: double.infinity,
//               height: screenHeight,
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.1,
//                 vertical: 50,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1000),
//                         child: Text(
//                           "Bienvenido!",
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: screenWidth * 0.08, // Ajuste dinámico
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.02), // Ajuste dinámico
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1200),
//                         child: Text(
//                           "Registrate y Se parte de nuestro equipo",
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             color: Colors.grey[700],
//                             fontSize: screenWidth * 0.05, // Ajuste dinámico
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   FadeInUp(
//                     duration: Duration(milliseconds: 1400),
//                     child: Container(
//                       height: screenHeight / 3, // Ajuste dinámico
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage('assets/Illustration.png'),
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Column(
//                     children: <Widget>[
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1500),
//                         child: MaterialButton(
//                           minWidth: double.infinity,
//                           height: screenHeight * 0.08, // Ajuste dinámico
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginPageYT(),
//                               ),
//                             );
//                           },
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(color: Colors.black),
//                             borderRadius: BorderRadius.circular(50),
//                           ),
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: screenWidth * 0.05, // Ajuste dinámico
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.02), // Ajuste dinámico
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1600),
//                         child: Container(
//                           padding: EdgeInsets.only(top: 3, left: 3),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border(
//                               bottom: BorderSide(color: Colors.black),
//                               top: BorderSide(color: Colors.black),
//                               left: BorderSide(color: Colors.black),
//                               right: BorderSide(color: Colors.black),
//                             ),
//                           ),
//                           child: MaterialButton(
//                             minWidth: double.infinity,
//                             height: screenHeight * 0.08, // Ajuste dinámico
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => SignupPageYT(),
//                                 ),
//                               );
//                             },
//                             color: Colors.greenAccent,
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: Text(
//                               "Sign up",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: screenWidth * 0.05, // Ajuste dinámico
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
