import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SignupPageYT extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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

          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1), // Ajuste dinámico
              height: screenHeight - 50,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            fontSize: screenWidth * 0.08, // Ajuste dinámico
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02), // Ajuste dinámico
                      FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: Text(
                          "Create an account, It's free",
                          style: TextStyle(fontSize: screenWidth * 0.05, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      FadeInUp(
                        duration: Duration(milliseconds: 1200),
                        child: makeInput(label: "Email"),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1300),
                        child: makeInput(label: "Password", obscureText: true),
                      ),
                      FadeInUp(
                        duration: Duration(milliseconds: 1400),
                        child: makeInput(
                          label: "Confirm Password",
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1500),
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
                          "Sign up",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: screenWidth * 0.05, // Ajuste dinámico
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1600),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Already have an account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: Text(
                            " Login",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: screenWidth * 0.05, // Ajuste dinámico
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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

// class SignupPageYT extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
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

//           return SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.symmetric(
//                 horizontal: screenWidth * 0.1,
//               ), // Ajuste dinámico
//               height: screenHeight - 50,
//               width: double.infinity,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1000),
//                         child: Text(
//                           "Sign up",
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.08, // Ajuste dinámico
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: screenHeight * 0.02), // Ajuste dinámico
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1200),
//                         child: Text(
//                           "Create an account, It's free",
//                           style: TextStyle(
//                             fontSize: screenWidth * 0.05,
//                             color: Colors.grey[700],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: <Widget>[
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1200),
//                         child: makeInput(label: "Email"),
//                       ),
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1300),
//                         child: makeInput(label: "Password", obscureText: true),
//                       ),
//                       FadeInUp(
//                         duration: Duration(milliseconds: 1400),
//                         child: makeInput(
//                           label: "Confirm Password",
//                           obscureText: true,
//                         ),
//                       ),
//                     ],
//                   ),
//                   FadeInUp(
//                     duration: Duration(milliseconds: 1500),
//                     child: Container(
//                       padding: EdgeInsets.only(top: 3, left: 3),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(50),
//                         border: Border(
//                           bottom: BorderSide(color: Colors.black),
//                           top: BorderSide(color: Colors.black),
//                           left: BorderSide(color: Colors.black),
//                           right: BorderSide(color: Colors.black),
//                         ),
//                       ),
//                       child: MaterialButton(
//                         minWidth: double.infinity,
//                         height: screenHeight * 0.08, // Ajuste dinámico
//                         onPressed: () {},
//                         color: Colors.greenAccent,
//                         elevation: 0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(50),
//                         ),
//                         child: Text(
//                           "Sign up",
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: screenWidth * 0.05, // Ajuste dinámico
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   FadeInUp(
//                     duration: Duration(milliseconds: 1600),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text("Already have an account?"),
//                         GestureDetector(
//                           onTap: () {
//                             Navigator.pushNamed(context, '/login');
//                           },
//                           child: Text(
//                             " Login",
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: screenWidth * 0.05, // Ajuste dinámico
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
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

