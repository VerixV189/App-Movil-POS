import 'package:flutter/material.dart';
import 'package:test/screens/CarritoPage/payment_modal.dart';

class CarritoScreen extends StatefulWidget {
  const CarritoScreen({super.key});

  @override
  State<CarritoScreen> createState() => _CarritoScreenState();
}

class _CarritoScreenState extends State<CarritoScreen> {
  List<Map<String, dynamic>> cartItems = [
    {
      'name': 'Mens Casual Slim Fit',
      'price': 15.99,
      'quantity': 4,
      'image': 'https://i.imgur.com/mw1VfJb.png',
    },
    {
      'name': 'Mens Cotton Jacket',
      'price': 55.99,
      'quantity': 1,
      'image': 'https://i.imgur.com/BvnGPuj.png',
    },
    {
      'name': 'Rain Jacket Windbreaker',
      'price': 39.99,
      'quantity': 3,
      'image': 'https://i.imgur.com/HpF2LrS.png',
    },
  ];

  double get totalPrice => cartItems.fold(
    0,
    (sum, item) => sum + (item['price'] as double) * (item['quantity'] as int),
  );

  void _changeQuantity(int index, int delta) {
    setState(() {
      cartItems[index]['quantity'] += delta;
      if (cartItems[index]['quantity'] <= 0) {
        cartItems.removeAt(index);
      }
    });
  }

  void _clearCart() {
    setState(() {
      cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return cartItems.isEmpty
        ? const Center(child: Text("Tu carrito está vacío"))
        : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: ListTile(
                      leading: Image.network(item['image'], width: 50),
                      title: Text(item['name']),
                      subtitle: Text("\$${item['price']}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: () => _changeQuantity(index, -1),
                          ),
                          Text(item['quantity'].toString()),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: () => _changeQuantity(index, 1),
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
                                    _clearCart();
                                  },
                                  child: const Text('Sí, vaciar'),
                                ),
                              ],
                            ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                    ),
                    child: const Text("Vaciar Carrito"),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Precio Total:",
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        "\$${totalPrice.toStringAsFixed(2)}",
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
                                total: totalPrice,
                                onPaymentSuccess: _clearCart,
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
