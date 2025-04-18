// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// const Color _kAppColor = Color(0xFFFDDE6F);
// const double _kSize = 100;
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         canvasColor: _kAppColor,
//         snackBarTheme: const SnackBarThemeData(
//           backgroundColor: Colors.brown,
//           contentTextStyle: TextStyle(fontSize: 20),
//         ),
//       ),
//       home: const HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late PageController _pageController;
//   int _currentPage = 0;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _currentPage);
//   }

//   void _onTapNext() {
//     if (_currentPage + 1 < listOfAnimations.length) {
//       _pageController.jumpToPage(_currentPage + 1);
//       setState(() {
//         _currentPage++;
//       });
//     } else {
//       _pageController.animateToPage(
//         0,
//         duration: const Duration(milliseconds: 800),
//         curve: Curves.ease,
//       );
//       setState(() {
//         _currentPage = 0;
//       });
//     }
//   }

//   void _onTapPrevious() {
//     if (_currentPage == 0) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('There is nothing left 🌚')));
//     } else {
//       _pageController.jumpToPage(_currentPage - 1);
//       setState(() {
//         _currentPage--;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageView(
//       physics: const NeverScrollableScrollPhysics(),
//       controller: _pageController,
//       children:
//           listOfAnimations
//               .map(
//                 (appBody) => Scaffold(
//                   body: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SafeArea(
//                         bottom: false,
//                         child: Text(
//                           appBody.title,
//                           style: const TextStyle(
//                             fontSize: 22,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                       Expanded(child: Center(child: appBody.widget)),
//                     ],
//                   ),
//                   bottomNavigationBar: SafeArea(
//                     top: false,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                             icon: const Icon(Icons.chevron_left_rounded),
//                             onPressed: _onTapPrevious,
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.chevron_right_rounded),
//                             onPressed: _onTapNext,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )
//               .toList(),
//     );
//   }
// }

// class AppBody {
//   final String title;
//   final Widget widget;
//   AppBody(this.title, this.widget);
// }

// final listOfAnimations = <AppBody>[
//   AppBody(
//     'waterydesert.com',
//     const Text(
//       'Total animations: 20',
//       textAlign: TextAlign.center,
//       style: TextStyle(fontSize: 18),
//     ),
//   ),
//   AppBody(
//     'waveDots',
//     LoadingAnimationWidget.waveDots(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'inkDrop',
//     LoadingAnimationWidget.inkDrop(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'twistingDots',
//     LoadingAnimationWidget.twistingDots(
//       leftDotColor: const Color(0xFF1A1A3F),
//       rightDotColor: const Color(0xFFEA3799),
//       size: _kSize,
//     ),
//   ),
//   AppBody(
//     'threeRotatingDots',
//     LoadingAnimationWidget.threeRotatingDots(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'staggeredDotsWave',
//     LoadingAnimationWidget.staggeredDotsWave(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'fourRotatingDots',
//     LoadingAnimationWidget.fourRotatingDots(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'fallingDot',
//     LoadingAnimationWidget.fallingDot(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'prograssiveDots',
//     LoadingAnimationWidget.progressiveDots(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'discreteCircle',
//     LoadingAnimationWidget.discreteCircle(
//       color: Colors.white,
//       size: _kSize,
//       secondRingColor: Colors.black,
//       thirdRingColor: Colors.purple,
//     ),
//   ),
//   AppBody(
//     'threeArchedCircle',
//     LoadingAnimationWidget.threeArchedCircle(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'bouncingBall',
//     LoadingAnimationWidget.bouncingBall(color: Colors.white, size: _kSize),
//   ),
//   //sexo
//   AppBody(
//     'flickr',
//     LoadingAnimationWidget.flickr(
//       leftDotColor: const Color(0xFF0063DC),
//       rightDotColor: const Color(0xFFFF0084),
//       size: _kSize,
//     ),
//   ),
//   AppBody(
//     'hexagonDots',
//     LoadingAnimationWidget.hexagonDots(color: const Color(0xFFFF0084), size: _kSize),
//   ),
//   AppBody(
//     'beat',
//     LoadingAnimationWidget.beat(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'twoRotatingArc',
//     LoadingAnimationWidget.twoRotatingArc(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'horizontalRotatingDots',
//     LoadingAnimationWidget.horizontalRotatingDots(
//       color: Colors.white,
//       size: _kSize,
//     ),
//   ),
//   AppBody(
//     'newtonCradle',
//     LoadingAnimationWidget.newtonCradle(color: Colors.white, size: 2 * _kSize),
//   ),
//   AppBody(
//     'stretchedDots',
//     LoadingAnimationWidget.stretchedDots(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'halfTriangleDot',
//     LoadingAnimationWidget.halfTriangleDot(color: Colors.white, size: _kSize),
//   ),
//   AppBody(
//     'dotsTriangle',
//     LoadingAnimationWidget.dotsTriangle(color: Colors.white, size: _kSize),
//   ),
// ];



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/auth/login_screen.dart';
import 'package:test/auth/register_screen.dart';
import 'package:test/auth/welcome_screen.dart';
import 'package:test/providers/LoadingProvider.dart';
import 'package:test/widgets/botton_bart.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LoadingProvider(), // Proveedor del estado de carga
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        //'/': (context) => WelcomePage(),
        '/': (context) => BottomNavPage(),
        '/login': (context) => LoginPageYT(),
        '/signup': (context) => SignupPageYT(),
        '/home':
            (context) => BottomNavPage(), // Pantalla principal después de login
      },
    );
  }
}
//version funcional
// import 'package:flutter/material.dart';
// import 'package:test/auth/home_screen.dart';
// import 'package:test/auth/login_screen.dart';
// import 'package:test/auth/register_screen.dart';
// import 'package:test/auth/welcome_screen.dart';


// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => WelcomePage(),
//         '/login': (context) => LoginPageYT(),
//         '/signup': (context) => SignupPageYT(),
//         '/home':
//             (context) => HomePageYT(), // Pantalla principal después de login
//       },
//     ),
//   );
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text('Tienes que presionar el boton varias veces:'),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
