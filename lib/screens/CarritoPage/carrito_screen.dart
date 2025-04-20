import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/interfaces/Carrito.dart';
import 'package:test/providers/CarritoProvider.dart';
import 'package:test/screens/CarritoPage/payment_modal.dart';
import 'package:test/services/carritoService.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () =>
          Provider.of<CarritoProvider>(context, listen: false).cargarCarrito(),
    );
  }

  // Future<void> _cargarCarrito() async {
  //   try {
  //     final data = await CarritoService.obtenerCarrito();
  //     setState(() {
  //       carrito = data;
  //       isLoading = false;
  //     });
  //   } catch (e) {
  //     print("Error al cargar el carrito: $e");
  //   }
  // }

  Future<void> _agregar(int productoId) async {
    await CarritoService.agregarProducto(productoId);
    Provider.of<CarritoProvider>(context, listen: false).cargarCarrito();
  }

  Future<void> _eliminar(int productoId) async {
    await CarritoService.eliminarProducto(productoId);
    Provider.of<CarritoProvider>(context, listen: false).cargarCarrito();
  }

  Future<void> _vaciarCarrito() async {
    await CarritoService.vaciarCarrito();
    Provider.of<CarritoProvider>(context, listen: false).cargarCarrito();
  }

  // void _clearCart() {
  //   setState(() {
  //     cartItems.clear();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final carritoProvider = Provider.of<CarritoProvider>(context);
    final carrito = carritoProvider.carrito;

    if (carrito == null) {
      return const Center(child: CircularProgressIndicator());
    }

    if (carrito.cardItems.isEmpty) {
      return const Center(child: Text("Tu carrito está vacío"));
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: carrito.cardItems.length,
            itemBuilder: (context, index) {
              final item = carrito.cardItems[index];
              final producto = item.producto;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: Image.network(
                    producto.imagenes.first.url_image,
                    width: 50,
                    errorBuilder:
                        (_, __, ___) => const Icon(Icons.broken_image),
                  ),
                  title: Text(producto.modelo.nombre),
                  subtitle: Text("${producto.precio} Bs"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () => _eliminar(producto.id),
                      ),
                      Text(item.cantidad.toString()),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () => _agregar(producto.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => AlertDialog(
                          title: const Text('Confirmar'),
                          content: const Text(
                            '¿Estás seguro de vaciar el carrito?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _vaciarCarrito();
                              },
                              child: const Text('Sí, vaciar'),
                            ),
                          ],
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
                child: const Text("Vaciar Carrito"),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Precio Total:", style: TextStyle(fontSize: 16)),
                  Text(
                    "${carrito.montoTotal} Bs",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder:
                          (context) => PaymentModal(
                            total: carrito.montoTotal,
                            onPaymentSuccess: _vaciarCarrito,
                          ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text("Pagar"),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget build(BuildContext context) {
//   return cartItems.isEmpty
//       ? const Center(child: Text("Tu carrito está vacío"))
//       : Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = cartItems[index];
//                 return Card(
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 16,
//                     vertical: 8,
//                   ),
//                   child: ListTile(
//                     leading: Image.network(item['image'], width: 50),
//                     title: Text(item['name']),
//                     subtitle: Text("\$${item['price']}"),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         IconButton(
//                           icon: const Icon(Icons.remove_circle_outline),
//                           onPressed: () => _changeQuantity(index, -1),
//                         ),
//                         Text(item['quantity'].toString()),
//                         IconButton(
//                           icon: const Icon(Icons.add_circle_outline),
//                           onPressed: () => _changeQuantity(index, 1),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder:
//                           (context) => AlertDialog(
//                             title: const Text('Confirmar'),
//                             content: const Text(
//                               '¿Estás seguro de vaciar el carrito?',
//                             ),
//                             actions: [
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context),
//                                 child: const Text('Cancelar'),
//                               ),
//                               TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   _clearCart();
//                                 },
//                                 child: const Text('Sí, vaciar'),
//                               ),
//                             ],
//                           ),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.yellow,
//                   ),
//                   child: const Text("Vaciar Carrito"),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text("Precio Total:", style: TextStyle(fontSize: 16)),
//                     Text(
//                       "\$${totalPrice.toStringAsFixed(2)}",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       showModalBottomSheet(
//                         context: context,
//                         isScrollControlled: true,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.vertical(
//                             top: Radius.circular(20),
//                           ),
//                         ),
//                         builder:
//                             (context) => PaymentModal(
//                               total: totalPrice,
//                               onPaymentSuccess: _clearCart,
//                             ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.yellow,
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                     ),
//                     child: const Text("Pagar"),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//               ],
//             ),
//           ),
//         ],
//       );
// }
