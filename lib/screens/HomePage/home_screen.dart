import 'package:flutter/material.dart';
import 'package:test/screens/HomePage/CategoryGrid.dart';
import 'package:test/screens/HomePage/ProductGrid.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text("Tienda")),
      //permite solo scrollVertical para todo el contenido
      body: SingleChildScrollView(
        child: Column(//para apilarlos uno encima del otro
          children: [
            const SizedBox(height: 16),
            const CategoryGrid(),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    "Productos",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const ProductGrid(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}





// // home_screen.dart
// import 'package:flutter/material.dart';
// import 'product_card.dart'; // Importa tu widget de tarjeta de producto

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sistema POS')),
//       body: Column(
//         children: [
//           // Barra de búsqueda o filtros
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               decoration: InputDecoration(
//                 labelText: 'Buscar...',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(),
//               ),
//             ),
//           ),

//           // Categorías (Ejemplo de categoría: "Electrónicos")
//           Expanded(
//             child: ListView.builder(
//               itemCount: 10, // Aquí deberían ir las categorías de productos
//               itemBuilder: (context, index) {
//                 return ProductCard(); // Usamos el widget ProductCard que muestra el producto
//               },
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shopping_cart),
//             label: 'Carrito',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Servicios',
//           ),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
//         ],
//       ),
//     );
//   }
// }
