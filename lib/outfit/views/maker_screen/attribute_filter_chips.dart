import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/backend/attribute_selection_manager.dart';
import 'package:wardrobe_app/cloth_item/views/selectable_attribute_chips.dart';

class OutfitMakerAtributeFilterChips extends StatelessWidget {
  final ClothItemAttributeSelectionManager selectionManager;

  const OutfitMakerAtributeFilterChips({
    super.key,
    required this.selectionManager,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: ClothItemSelectableAttributeChips(
        selectionManager: selectionManager,
      ),
    );
  }
}
