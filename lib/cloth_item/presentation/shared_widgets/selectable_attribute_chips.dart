import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/attributes.dart';

import '../shared_presenters/attribute_selection_manager.dart';

class ClothItemSelectableAttributeChips extends StatelessWidget {
  final ClothItemAttributeSelectionManager selectionManager;

  const ClothItemSelectableAttributeChips({
    super.key,
    required this.selectionManager,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: selectionManager,
      builder: (_, __) => Wrap(
        spacing: 8.0,
        children: _chips,
      ),
    );
  }

  List<Widget> get _chips {
    return [
      for (final attribute in ClothItemAttribute.values)
        _SelectableAttributeChip(
          selectionManager: selectionManager,
          attribute: attribute,
        )
    ];
  }
}

class _SelectableAttributeChip extends StatelessWidget {
  final ClothItemAttributeSelectionManager selectionManager;
  final ClothItemAttribute attribute;

  const _SelectableAttributeChip({
    required this.selectionManager,
    required this.attribute,
  });

  @override
  Widget build(BuildContext context) {
    return _isSelected ? _selectedChip(context) : _unselectedChip;
  }

  Widget get _unselectedChip {
    return GestureDetector(
      onTap: _select,
      child: Chip(
        label: _label,
        avatar: _avatar,
      ),
    );
  }

  Widget _selectedChip(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primaryContainer;
    return GestureDetector(
      onTap: _unselect,
      child: Chip(
        label: _label,
        avatar: _avatar,
        backgroundColor: activeColor,
        deleteIcon: const Icon(Icons.cancel),
        onDeleted: _unselect,
      ),
    );
  }

  Widget get _label => Text(ClothItemAttributeDisplayConfig.of(attribute).name);
  Widget get _avatar =>
      Icon(ClothItemAttributeDisplayConfig.of(attribute).icon);

  void _select() => selectionManager.selectAttribute(attribute);
  void _unselect() => selectionManager.unselectAttribute(attribute);

  bool get _isSelected => selectionManager.attributeIsSelected(attribute);
}
