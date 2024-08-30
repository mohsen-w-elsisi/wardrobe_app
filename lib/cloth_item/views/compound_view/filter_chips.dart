import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/dispay_options/attribute.dart';
import 'package:wardrobe_app/cloth_item/dispay_options/type.dart';
import 'package:wardrobe_app/cloth_item/views/compound_view/settings.dart';

class ClothItemCompoundViewFilterChips extends StatelessWidget {
  final ClothItemCompoundViewManager _viewManager;
  final ClothItemCompoundViewSettings _viewSettings;

  ClothItemCompoundViewFilterChips({
    super.key,
    required ClothItemCompoundViewManager viewManager,
  })  : _viewManager = viewManager,
        _viewSettings = viewManager.settings;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Wrap(
        spacing: 8,
        children: [
          if (_viewSettings.showOnlyType != null) _typeChip,
          ..._attributeChips,
        ],
      ),
    );
  }

  _TypeChip get _typeChip {
    return _TypeChip(
      type: _viewSettings.showOnlyType!,
      viewManager: _viewManager,
    );
  }

  List<_AttributeChip> get _attributeChips {
    return [
      for (final filterAttribute in _viewSettings.filteredAttributes)
        _AttributeChip(
          filterAttribute: filterAttribute,
          viewManager: _viewManager,
        )
    ];
  }
}

class _AttributeChip extends StatelessWidget {
  final ClothItemAttribute _filterAttribute;
  final ClothItemCompoundViewManager _viewManager;

  const _AttributeChip({
    required ClothItemAttribute filterAttribute,
    required ClothItemCompoundViewManager viewManager,
  })  : _filterAttribute = filterAttribute,
        _viewManager = viewManager;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(_attributeDisplayoption.name),
      avatar: Icon(_attributeDisplayoption.icon),
      deleteIcon: const Icon(Icons.cancel),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      onDeleted: _removeAttributeFromFilters,
    );
  }

  void _removeAttributeFromFilters() {
    _viewManager.removeFilteredAttribute(_filterAttribute);
  }

  ClothItemAttributeDisplayOption get _attributeDisplayoption {
    return clothItemAttributeDisplayOptions[_filterAttribute]!;
  }
}

class _TypeChip extends StatelessWidget {
  final ClothItemType _type;
  final ClothItemCompoundViewManager _viewManager;

  const _TypeChip({
    required ClothItemCompoundViewManager viewManager,
    required ClothItemType type,
  })  : _viewManager = viewManager,
        _type = type;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(_label),
      avatar: _icon(context),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      deleteIcon: const Icon(Icons.cancel),
      onDeleted: _viewManager.showAllTypes,
    );
  }

  String get _label => clothItemTypeDisplayOptions[_type]!.text;

  Widget _icon(BuildContext context) =>
      SvgPicture.asset(ClothItemTypeIconQuerier(context, _type).icon);
}
