import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoginPageYT extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenHeight = constraints.maxHeight;
          double screenWidth = constraints.maxWidth;

          return Container(
            height: screenHeight,
            width: screenWidth,
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
                                fontSize: screenWidth * 0.08, // Ajuste dinámico
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: screenHeight * 0.02,
                          ), // Ajuste dinámico
                          FadeInUp(
                            duration: Duration(milliseconds: 1200),
                            child: Text(
                              "Login to your account",
                              style: TextStyle(
                                fontSize: screenWidth * 0.04, // Ajuste dinámico
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.1,
                        ), // Ajuste dinámico
                        child: Column(
                          children: <Widget>[
                            FadeInUp(
                              duration: Duration(milliseconds: 1200),
                              child: makeInput(label: "Email"),
                            ),
                            FadeInUp(
                              duration: Duration(milliseconds: 1300),
                              child: makeInput(
                                label: "Contraseña",
                                obscureText: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1400),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.1,
                          ), // Ajuste dinámico
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
                              onPressed: () {},
                              color: Colors.greenAccent,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      screenWidth * 0.05, // Ajuste dinámico
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
                            Text("Don't have an account?"),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, '/signup');
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      screenWidth * 0.05, // Ajuste dinámico
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
                    height: screenHeight / 3,
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
          );
        },
      ),
    );
  }

  Widget makeInput({label, obscureText = false}) {
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
        TextField(
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
        ),
        SizedBox(height: 30),
      ],
    );
  }
}

//supuesto responsive
// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';

// class LoginPageYT extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double screenHeight = constraints.maxHeight;
//           double screenWidth = constraints.maxWidth;

//           return Container(
//             height: screenHeight,
//             width: screenWidth,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Column(
//                         children: <Widget>[
//                           FadeInUp(
//                             duration: Duration(milliseconds: 1000),
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                 fontSize: screenWidth * 0.08, // Ajuste dinámico
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           SizedBox(
//                             height: screenHeight * 0.02,
//                           ), // Ajuste dinámico
//                           FadeInUp(
//                             duration: Duration(milliseconds: 1200),
//                             child: Text(
//                               "Login to your account",
//                               style: TextStyle(
//                                 fontSize: screenWidth * 0.04, // Ajuste dinámico
//                                 color: Colors.grey[700],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Padding(
//                         padding: EdgeInsets.symmetric(
//                           horizontal: screenWidth * 0.1,
//                         ), // Ajuste dinámico
//                         child: Column(
//                           children: <Widget>[
//                             FadeInUp(
//                               duration: Duration(milliseconds: 1200),
//                               child: makeInput(label: "Email"),
//                             ),
//                             FadeInUp(
//                               duration: Duration(milliseconds: 1300),
//                               child: makeInput(
//                                 label: "Contraseña",
//                                 obscureText: true,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1400),
//                         child: Padding(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: screenWidth * 0.1,
//                           ), // Ajuste dinámico
//                           child: Container(
//                             padding: EdgeInsets.only(top: 3, left: 3),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               border: Border(
//                                 bottom: BorderSide(color: Colors.black),
//                                 top: BorderSide(color: Colors.black),
//                                 left: BorderSide(color: Colors.black),
//                                 right: BorderSide(color: Colors.black),
//                               ),
//                             ),
//                             child: MaterialButton(
//                               minWidth: double.infinity,
//                               height: screenHeight * 0.08, // Ajuste dinámico
//                               onPressed: () {},
//                               color: Colors.greenAccent,
//                               elevation: 0,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50),
//                               ),
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize:
//                                       screenWidth * 0.05, // Ajuste dinámico
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1500),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text("Don't have an account?"),
//                             GestureDetector(
//                               onTap: () {
//                                 Navigator.pushNamed(context, '/signup');
//                               },
//                               child: Text(
//                                 "Sign up",
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize:
//                                       screenWidth * 0.05, // Ajuste dinámico
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 FadeInUp(
//                   duration: Duration(milliseconds: 1200),
//                   child: Container(
//                     height: screenHeight / 3,
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/background.png'),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget makeInput({label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w400,
//             color: Colors.black87,
//           ),
//         ),
//         SizedBox(height: 5),
//         TextField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey.shade400),
//             ),
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey.shade400),
//             ),
//           ),
//         ),
//         SizedBox(height: 30),
//       ],
//     );
//   }
// }
