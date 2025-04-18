import 'package:flutter/material.dart';
import 'package:test/widgets/custom_header.dart';
import 'package:test/screens/HomePage/home_screen.dart';
import 'package:test/screens/carrito_screen.dart';
import 'package:test/screens/servicios_screen.dart';
import 'package:test/screens/HomePage/perfil_screen.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    // ServiciosScreen(),
    // CarritoScreen(),
     PerfilScreen(),
    Center(child: Text("Servicios próximamente")),
    Center(child: Text("Carrito próximamente")),
    Center(child: Text("Perfil próximamente")),
  ];

  final List<String> _titles = const [
    'Inicio',
    'Servicios',
    'Carrito',
    'Perfil',
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: CustomHeader(title: _titles[_selectedIndex]),
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          backgroundColor: Colors.white,
          indicatorColor: Colors.cyan.shade100,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.build_outlined),
              selectedIcon: Icon(Icons.build),
              label: 'Servicios',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_cart_outlined),
              selectedIcon: Icon(Icons.shopping_cart),
              label: 'Carrito',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }
}
