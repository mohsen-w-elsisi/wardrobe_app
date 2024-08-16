import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';
import 'package:wardrobe_app/utils/cloth_item_selectable_attribute_chips.dart';
import 'package:wardrobe_app/utils/cloth_item_attribute_selection_manager.dart';

class NewClothItemScreenAttributeSelector extends StatelessWidget {
  final NewClothItemManager newClothItemManager;
  late final ClothItemAttributeSelectionManager _selectionManager;

  NewClothItemScreenAttributeSelector({
    super.key,
    required this.newClothItemManager,
  }) {
    _initSelectionManager();
    _watchSelectionAndUpdateNewClothItem();
  }

  void _initSelectionManager() {
    _selectionManager = ClothItemAttributeSelectionManager(
      newClothItemManager.attributes.toSet(),
    );
  }

  void _watchSelectionAndUpdateNewClothItem() {
    _selectionManager.addListener(_updateNewClothItem);
  }

  void _updateNewClothItem() {
    newClothItemManager.attributes =
        _selectionManager.selectedAttributes.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 8),
      child: ClothItemSelectableAttributeChips(
        selectionManager: _selectionManager,
      ),
    );
  }
}
