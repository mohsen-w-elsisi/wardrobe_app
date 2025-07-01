import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/types.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/type_selection_manager.dart';

class ClothItemSelectableTypeChips extends StatelessWidget {
  final ClothItemTypeSelectionManager selectionManager;

  const ClothItemSelectableTypeChips({
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
      for (final type in ClothItemType.values)
        _SelectableTypeChip(
          selectionManager: selectionManager,
          type: type,
        )
    ];
  }
}

class _SelectableTypeChip extends StatelessWidget {
  final ClothItemTypeSelectionManager selectionManager;
  final ClothItemType type;

  const _SelectableTypeChip({
    required this.selectionManager,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return _isSelected ? _selectedChip(context) : _unselectedChip(context);
  }

  Widget _unselectedChip(BuildContext context) {
    return GestureDetector(
      onTap: _select,
      child: Chip(
        label: _label,
        avatar: _avatar(context),
      ),
    );
  }

  Widget _selectedChip(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primaryContainer;
    return GestureDetector(
      onTap: _unselect,
      child: Chip(
        label: _label,
        avatar: _avatar(context),
        backgroundColor: activeColor,
        deleteIcon: const Icon(Icons.cancel),
        onDeleted: _unselect,
      ),
    );
  }

  Widget get _label => Text(ClothItemTypeDisplayConfig.of(type).text);

  Widget _avatar(BuildContext context) {
    return SvgPicture.asset(
      ClothItemTypeDisplayConfig.of(type).iconPath(context),
      height: 16,
    );
  }

  void _select() => selectionManager.selectType(type);
  void _unselect() => selectionManager.unselectType(type);

  bool get _isSelected => selectionManager.typeIsSelected(type);
}
