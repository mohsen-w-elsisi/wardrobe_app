import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/views/editing_screen/new_screen/image_source_selector_modal.dart';
import 'package:wardrobe_app/cloth_item/backend/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/views/image.dart';

class NewClothItemPhotoSelector extends StatelessWidget {
  final NewClothItemManager newClothItemManager;

  const NewClothItemPhotoSelector({
    super.key,
    required this.newClothItemManager,
  });

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) => GestureDetector(
        onTap: () => _showImageSourceOptions(context, setState),
        child: newClothItemManager.image.isEmpty
            ? _blankImageSelector(context)
            : _filledImageSelector(),
      ),
    );
  }

  void _showImageSourceOptions(BuildContext context, StateSetter setState) {
    ImageSelectorModal(
      newClothItemManager: newClothItemManager,
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
        tag: newClothItemManager.id ?? "",
        child: ClothItemImage(image: newClothItemManager.image),
      );
}
