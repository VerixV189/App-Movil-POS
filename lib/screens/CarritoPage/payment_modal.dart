import 'package:flutter/material.dart';

class PaymentModal extends StatelessWidget {
  final VoidCallback onPaymentSuccess;
  final double total;

  const PaymentModal({
    super.key,
    required this.total,
    required this.onPaymentSuccess,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.92,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test mode banner
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                "TEST MODE",
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Add your payment information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Card Number
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Card number",
                hintText: "4242 4242 4242 4242",
                prefixIcon: Icon(Icons.credit_card),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Expiry & CVC
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.datetime,
                    decoration: const InputDecoration(
                      labelText: "MM / YY",
                      hintText: "01 / 25",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "CVC",
                      hintText: "123",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Billing Address
            const Text(
              "Billing address",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: "Country or region",
                border: OutlineInputBorder(),
              ),
              value: "United States",
              items: const [
                DropdownMenuItem(
                  value: "United States",
                  child: Text("United States"),
                ),
                DropdownMenuItem(value: "Bolivia", child: Text("Bolivia")),
                DropdownMenuItem(value: "Argentina", child: Text("Argentina")),
              ],
              onChanged: (_) {},
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: const InputDecoration(
                labelText: "ZIP Code",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            // Pay Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onPaymentSuccess();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Pago simulado realizado con éxito"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Pay \$${total.toStringAsFixed(2)}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

