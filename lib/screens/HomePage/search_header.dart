

import 'package:flutter/material.dart';

class SearchHeader extends StatelessWidget {
  const SearchHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        color: Colors.cyan,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // fondo blanco para la barra de búsqueda
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          height: 45,
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: "Buscar productos...",
                    border: InputBorder.none,
                    isDense: true,
                  ),
                  style: const TextStyle(fontSize: 14),
                  onSubmitted: (value) {
                    // Acción al presionar enter o buscar
                    print("Buscando: $value");
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.qr_code_scanner, color: Colors.grey),
                onPressed: () {
                  // funcionalidad futura
                },
              ),
              IconButton(
                icon: const Icon(Icons.mic, color: Colors.grey),
                onPressed: () {
                  // funcionalidad futura
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
