// // carrito_screen.dart
// import 'package:flutter/material.dart';

// class CarritoScreen extends StatefulWidget {
//   @override
//   _CarritoScreenState createState() => _CarritoScreenState();
// }

// class _CarritoScreenState extends State<CarritoScreen> {
//   int cantidad = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Carrito de Compras")),
//       body: Column(
//         children: [
//           // Lista de productos en el carrito
//           ListTile(
//             leading: Image.network('URL_IMAGEN_DEL_PRODUCTO'),
//             title: Text('Producto X'),
//             subtitle: Text('\$10.99'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.remove),
//                   onPressed: () {
//                     if (cantidad > 1) {
//                       setState(() {
//                         cantidad--;
//                       });
//                     }
//                   },
//                 ),
//                 Text('$cantidad'),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     setState(() {
//                       cantidad++;
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           // Botón de pago
//           ElevatedButton(
//             onPressed: () {
//               // Lógica para realizar el pago
//             },
//             child: Text('Pagar'),
//           ),
//         ],
//       ),
//     );
//   }
// }
