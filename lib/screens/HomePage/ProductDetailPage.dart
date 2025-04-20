import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/BackendExceptionDTO.dart';
import 'package:test/models/interfaces/IComentario.dart';
import 'package:test/models/interfaces/IProducto.dart';
import 'package:test/providers/UserProvider.dart';
import 'package:test/screens/HomePage/ImageModalViewer.dart';
import 'package:test/services/API/server_url.dart';
import 'package:test/services/comentarioService.dart';
import 'package:test/services/producto_service.dart';
import 'package:test/widgets/reviews/add_comment_modal.dart';
import 'package:test/widgets/reviews/comment_card.dart';
import 'package:test/widgets/reviews/rating_summary.dart';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({Key? key, required this.productId})
    : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<Producto> _productoFuture;

  @override
  void initState() {
    super.initState();
    _loadProducto();
  }

  void _loadProducto() {
    _productoFuture = ProductoService.getProductoCompleto(widget.productId);
  }


  //para cuando se agrega comentarios o se editar o se elimina
  void _refreshProducto() async {
    final productoActualizado = await ProductoService.getProductoCompleto(
      widget.productId,
    );

    setState(() {
      _productoFuture = Future.value(productoActualizado);
    });
  }


  //METODOS PARA EDITAR Y ELIMINAR EL COMENTARIO
  void _showEditModal(Comentario comentario) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return AddCommentModal(
          initialComment: comentario.descripcion,
          initialStars: comentario.puntuacion,
          onSubmit: (stars, text) async {
            await ComentarioService.editarComentario(
              comentarioId: comentario.id,
              puntuacion: stars,
              descripcion: text,
            );
            _refreshProducto(); // recarga
          },
        );
      },
    );
  }

  void _confirmDelete(int idComentario) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Eliminar comentario"),
            content: const Text(
              "¿Estás seguro de que deseas eliminar este comentario?",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancelar"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text("Eliminar"),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await ComentarioService.eliminarComentario(idComentario);
      _refreshProducto();
    }
  }

  Future<void> _agregarComentario(int estrellas, String comentario) async {
    try {
      await ComentarioService.crearComentario(
        productoId: widget.productId,
        puntuacion: estrellas,
        descripcion: comentario,
      );
      // Navigator.pop(context); // Cierra el modal, ya lo hace el metodo del modal
      _refreshProducto(); // Refresca la vista 
    } on BackendException catch (e) {
      print("error ocurrio algunos errores al agregar el comentario ${e.message}");
    } catch (e) {
      print("❌ Error al crear comentario: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al enviar el comentario")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Producto>(
      future: _productoFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          print('❌ Error en ProductDetailPage: ${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Text('Error al obtener el producto: ${snapshot.error}'),
            ),
          );
        }

        final producto = snapshot.data!;
        print("📊 Estadísticas de puntuaciones: ${producto.estadisticas}");

        final imagenes = producto.imagenes.map((e) => e.url_image).toList();

        return Scaffold(
          appBar: AppBar(
            title: Text(producto.modelo.nombre),
            backgroundColor: Colors.cyan.shade700,
            foregroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: producto.id,
                  child: SizedBox(
                    height: 280,
                    child: PageView.builder(
                      controller: PageController(viewportFraction: 0.92),
                      itemCount: imagenes.length,
                      itemBuilder: (context, index) {
                        final imageUrl = imagenes[index];

                        return GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => ImageModalViewer(imageUrl: imageUrl),
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                errorBuilder:
                                    (context, error, stackTrace) =>
                                        const Center(
                                          child: Icon(Icons.broken_image),
                                        ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  producto.modelo.nombre,

                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\ ${producto.precio} Bs',
                  style: const TextStyle(fontSize: 20, color: Colors.cyan),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 20,
                    ),
                  ),
                  icon: const Icon(Icons.add_shopping_cart),
                  label: const Text("Agregar al carrito"),
                ),
                const SizedBox(height: 24),

                RatingSummary(
                  averageRating: producto.media_puntaje,
                  totalRatings: producto.comentarios.length,
                  ratingDistribution: producto.estadisticas,
                ),
                const SizedBox(height: 24),
                const Text(
                  "Descripción",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(producto.descripcion, textAlign: TextAlign.justify),
                const SizedBox(height: 24),
                const Text(
                  "Características",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ..._buildCaracteristicas(producto.caracteristica),
                const SizedBox(height: 24),
                const Text(
                  "Comentarios",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                producto.comentarios.isEmpty
                    ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Center(
                        child: Text(
                          "Este producto aún no tiene comentarios.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                    : Column(
                      children:
                          producto.comentarios.map(_buildCommentTile).toList(),
                    ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return AddCommentModal(
                              // enviar comentario
                              
                              onSubmit: (stars,comment) => _agregarComentario(stars, comment),
                              
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.add_comment_outlined),
                      label: const Text("Agregar comentario"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildCaracteristicas(caract) {
    final Map<String, String?> map = {
      'Modelo': caract.modelo,
      'Pantalla': caract.pantalla,
      'RAM': caract.ram,
      'Almacenamiento': caract.almacenamiento,
      'Procesador': caract.procesador,
      'Sistema Operativo': caract.sistemaOperativo,
      'Batería': caract.bateria,
      'Resolución': caract.resolucion,
      'Cámara': caract.camara,
      'Puertos': caract.puertos,
    };
    return map.entries
        .where((e) => e.value != null)
        .map((e) => Text("\u2022 \ ${e.key}: \ ${e.value}"))
        .toList();
  }

  Widget _buildCommentTile(Comentario comentario) {
    final authenticatedUser = Provider.of<UserProvider>(context, listen: false);
    
    final isCurrentUser = authenticatedUser.usuario?.id == comentario.usuario.id;
    return CommentCard(
      username: comentario.usuario.username,
      date: '${comentario.fecha} - ${comentario.hora}',
      content: comentario.descripcion,
      stars: comentario.puntuacion,
      isCurrentUser: isCurrentUser,
      urlProfile: comentario.usuario.url_profile,
      onEdit: isCurrentUser ? () => _showEditModal(comentario) : null,
      onDelete: isCurrentUser ? () => _confirmDelete(comentario.id) : null,
    );
  }
}
