import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/CategoriaProvider.dart';
import 'package:test/providers/ProductoProvider.dart';
import 'package:test/services/categoriaService.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({super.key});

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  int selectedIndex = 0;//para el estado del boton

//iconos de categorias
  List<Map<String, dynamic>> categories = [];

  @override
  void initState() {
    super.initState();
    _fetchCategorias();
  }

  Future<void> _fetchCategorias() async {
    final data = await CategoriaService.getAllCategory();
    print("Categorias desde backend: $data");

    final iconos = [
      Icons.phone_android,
      Icons.tv,
      Icons.watch,
      Icons.headphones,
      Icons.keyboard,
      Icons.laptop_mac,
      Icons.tablet_mac,
      Icons.videogame_asset,
      Icons.monitor,
    ];

    final dinamicas =
    //convierte la lista de categorias en lista clave valor
    //resulado
//     [
//   {'id': 11, 'label': 'CELULARES', 'icon': Icons.phone_android},
//   {'id': 12, 'label': 'TV', 'icon': Icons.tv},
//   ...
// ]
        data.asMap().entries.map((entry) {
          final index = entry.key;
          final categoria = entry.value;
          return {
            'id': categoria.id,
            'label': categoria.nombre,
            'icon': iconos[index % iconos.length],
          };
        }).toList();

     setState(() {
      categories = [
        ...dinamicas,
        {'icon': Icons.grid_view, 'label': 'Todos', 'id': 0},
      ];

      selectedIndex = 0; 
    });

    final productProvider = Provider.of<ProductProvider>(
      context,
      listen: false,
    );
    //primera llamda por defecto
    await productProvider.fetchByCategoria(categories[0]['id']);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.95, // 🔧 Ajustado para que quepa mejor
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          final cat = categories[index];
          final isSelected = selectedIndex == index;
          //para detectar tap
          return GestureDetector(
            onTap: () async {
              setState(() {
                selectedIndex = index;
              });
              print("Categoría seleccionada: ${cat['label']}");

              Provider.of<CategoriaSeleccionadaProvider>(
                  context,
                  listen: false,
              ).setCategoria(cat['id']);


              final productProvider = Provider.of<ProductProvider>(context, listen: false);
              await productProvider.fetchByCategoria(cat['id']);

            },
            //para la animacion y fondo
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: isSelected ? Colors.cyan.shade100 : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isSelected ? Colors.cyan : Colors.transparent,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              //adaptacion sin desborde
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      cat['icon'],
                      size: 22,
                      color: isSelected ? Colors.cyan.shade800 : Colors.grey,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cat['label'],
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color:
                            isSelected ? Colors.cyan.shade800 : Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
