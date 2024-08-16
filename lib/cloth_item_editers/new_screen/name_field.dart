import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';

class NewClothItemNameField extends StatefulWidget {
  final NewClothItemManager newClothItemManager;

  const NewClothItemNameField({required this.newClothItemManager});

  @override
  State<NewClothItemNameField> createState() => _NewClothItemNameFieldState();
}

class _NewClothItemNameFieldState extends State<NewClothItemNameField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.newClothItemManager.name);
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
      onChanged: (text) => widget.newClothItemManager.name = text,
      decoration: const InputDecoration(labelText: "name"),
    );
  }
}
