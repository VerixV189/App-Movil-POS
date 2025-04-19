import 'package:flutter/material.dart';
import 'package:test/screens/CarritoPage/carrito_screen.dart';
import 'package:test/screens/HomePage/search_header.dart';
import 'package:test/screens/PerfilPage/perfil_screen.dart';
import 'package:test/widgets/custom_header.dart';
import 'package:test/screens/HomePage/home_screen.dart';
import 'package:test/screens/carrito_screen.dart';
import 'package:test/screens/ServicioPage/servicios_screen.dart';


class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage> {
  int _selectedIndex = 0;

    //  ServiciosScreen(),
    //  CarritoScreen(),
  final List<Widget> _pages = [
    HomeScreen(),
    ServiciosScreen(),
    CarritoScreen(),
    //const Center(child: Text("Servicios próximamente")),
    //const Center(child: Text("Carrito próximamente")),
    //PerfilScreen(),
    PerfilScreen(),
    //Builder(builder: (_) => PerfilScreen()),
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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child:
              _selectedIndex == 0
                  ? const SearchHeader() // <-- Tu nuevo header solo en Inicio
                  : CustomHeader(title: _titles[_selectedIndex]),
        ),

        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: _selectedIndex,
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          height: 70,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
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
