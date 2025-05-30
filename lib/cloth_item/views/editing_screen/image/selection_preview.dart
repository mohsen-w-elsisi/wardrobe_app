import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/views/editing_screen/image/selection_model.dart';
import 'package:wardrobe_app/cloth_item/presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/views/image.dart';

class ClothItemImageSelectionPreview extends StatelessWidget {
  final ClothItemEditingManager editingManager;

  const ClothItemImageSelectionPreview({
    super.key,
    required this.editingManager,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => GestureDetector(
        onTap: () => _showImageSourceOptions(context, setState),
        child: editingManager.image.isEmpty
            ? _blankImageSelector(context)
            : _filledImageSelector(),
      ),
    );
  }

  void _showImageSourceOptions(BuildContext context, StateSetter setState) {
    ClothItemImageSelectionModal(
      editingManager: editingManager,
      onSelect: () => setState(() {}),
    ).show(context);
  }

  Widget _blankImageSelector(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).colorScheme.secondaryFixedDim,
        ),
        child: const Center(
          child: Icon(Icons.camera_alt, size: 48),
        ),
      ),
    );
  }

  Widget _filledImageSelector() => Hero(
        tag: editingManager.id ?? "",
        child: RoundedSquareImage(
          MemoryImage(
            editingManager.image,
          ),
        ),
      );
}
