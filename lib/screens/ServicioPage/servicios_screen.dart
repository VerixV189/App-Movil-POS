import 'package:flutter/material.dart';

class ServiciosScreen extends StatelessWidget {
  // Simulación de datos de servicios
  final List<Map<String, dynamic>> servicios = [
    {'id': 101, 'fecha': '16/04/2025', 'monto': 120.50},
    {'id': 102, 'fecha': '15/04/2025', 'monto': 89.99},
    {'id': 103, 'fecha': '14/04/2025', 'monto': 220.00},
  ];

  ServiciosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: servicios.length,
      itemBuilder: (context, index) {
        final servicio = servicios[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.yellow,
              child: Text(servicio['id'].toString()),
            ),
            title: Text("Fecha: ${servicio['fecha']}"),
            subtitle: Text("Monto: \$${servicio['monto'].toStringAsFixed(2)}"),
            trailing: IconButton(
              icon: const Icon(Icons.picture_as_pdf),
              color: Colors.red,
              onPressed: () {
                // Acción para imprimir servicio (generar PDF)
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Generando reporte PDF...")),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
