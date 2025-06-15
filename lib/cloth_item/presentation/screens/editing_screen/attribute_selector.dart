import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/selectable_attribute_chips.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/attribute_selection_manager.dart';

class ClothItemAttributeSelector extends StatelessWidget {
  final ClothItemEditingManager editingManager;
  late final ClothItemAttributeSelectionManager _selectionManager;

  ClothItemAttributeSelector({
    super.key,
    required this.editingManager,
  }) {
    _initSelectionManager();
    _watchSelectionAndUpdateNewClothItem();
  }

  void _initSelectionManager() {
    _selectionManager = ClothItemAttributeSelectionManager(
      editingManager.attributes.toSet(),
    );
  }

  void _watchSelectionAndUpdateNewClothItem() {
    _selectionManager.addListener(_updateNewClothItem);
  }

  void _updateNewClothItem() {
    editingManager.attributes = _selectionManager.selectedAttributes.toList();
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
