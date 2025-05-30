import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/presenters/new_item_manager.dart';

class ClothItemNameField extends StatefulWidget {
  final ClothItemEditingManager editingManager;

  const ClothItemNameField({super.key, required this.editingManager});

  @override
  State<ClothItemNameField> createState() => _ClothItemNameFieldState();
}

class _ClothItemNameFieldState extends State<ClothItemNameField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.editingManager.name);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (text) => widget.editingManager.name = text,
      decoration: const InputDecoration(labelText: "name"),
    );
  }
}
