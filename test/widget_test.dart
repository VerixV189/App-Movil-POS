// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// import 'package:test/main.dart';

// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(const MyApp());

//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);

//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();

//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test/auth/welcome_screen.dart';
import 'package:test/main.dart'; // Asegúrate de que este sea el import correcto
import 'package:test/auth/login_screen.dart';
import 'package:test/auth/register_screen.dart';
import 'package:test/auth/home_screen.dart';

void main() {
  testWidgets('LoginPage and SignupPage test', (WidgetTester tester) async {
    // Construir la aplicación
    await tester.pumpWidget(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => WelcomePage(),
          '/login': (context) => LoginPageYT(),
          '/signup': (context) => SignupPageYT(),
          '/home':
              (context) => HomePageYT(), // Pantalla principal después de login
        },
      ),
    );

    // Verificar que la pantalla de inicio muestre los botones de login y signup
    expect(
      find.text('Welcome'),
      findsOneWidget,
    ); // Puedes verificar que "Welcome" esté en pantalla
    expect(
      find.byType(MaterialButton),
      findsNWidgets(2),
    ); // Verificar si hay dos botones (login y signup)

    // Tocar el botón de login y verificar que la LoginPage aparezca
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.byType(LoginPageYT), findsOneWidget);

    // Tocar el botón de signup y verificar que la SignupPage aparezca
    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    expect(find.byType(SignupPageYT), findsOneWidget);
  });
}
