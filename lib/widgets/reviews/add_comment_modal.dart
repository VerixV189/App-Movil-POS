import 'package:flutter/material.dart';

class AddCommentModal extends StatefulWidget {
  final void Function(int stars, String comment) onSubmit;

  //para edicion
  final String? initialComment;
  final int? initialStars;

  
  const AddCommentModal({
    Key? key,
    required this.onSubmit,
    this.initialComment,
    this.initialStars,
  }) : super(key: key);

  @override
  State<AddCommentModal> createState() => _AddCommentModalState();
}

class _AddCommentModalState extends State<AddCommentModal> {
  // int _selectedStars = 5;
  //final TextEditingController _controller = TextEditingController();

  late int _selectedStars;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _selectedStars = widget.initialStars ?? 5;
    _controller = TextEditingController(text: widget.initialComment ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          MediaQuery.of(context).viewInsets, // Para evitar el teclado encima
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Wrap(
          children: [
            const Center(
              child: Text(
                "Agregar comentario",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _selectedStars ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedStars = index + 1;
                    });
                  },
                );
              }),
            ),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Escribe tu comentario...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                widget.onSubmit(_selectedStars, _controller.text.trim());
                Navigator.pop(context);
              },
              icon: const Icon(Icons.send),
              label: const Text("Enviar"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
