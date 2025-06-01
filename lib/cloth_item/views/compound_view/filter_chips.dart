import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/presenters/attribute_display_options.dart';
import 'package:wardrobe_app/cloth_item/presenters/type_display_options.dart';
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
    final chips = [..._attributeChips, ..._typeChips];

    return chips.isEmpty
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: chips,
            ),
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

  List<_TypeChip> get _typeChips {
    return [
      for (final filterType in _viewSettings.filteredTypes)
        _TypeChip(
          viewManager: _viewManager,
          type: filterType,
        )
    ];
  }
}

class _AttributeChip extends _FilterChip {
  final ClothItemAttribute _filterAttribute;
  final ClothItemCompoundViewManager _viewManager;

  const _AttributeChip({
    required ClothItemAttribute filterAttribute,
    required ClothItemCompoundViewManager viewManager,
  })  : _filterAttribute = filterAttribute,
        _viewManager = viewManager;

  @override
  void _removeFilter() {
    _viewManager.removeFilteredAttribute(_filterAttribute);
  }

  @override
  String get _label => _attributeDisplayoption.name;

  @override
  Widget _avatar(_) => Icon(_attributeDisplayoption.icon);

  ClothItemAttributeDisplayOption get _attributeDisplayoption {
    return clothItemAttributeDisplayOptions[_filterAttribute]!;
  }
}

class _TypeChip extends _FilterChip {
  final ClothItemType _type;
  final ClothItemCompoundViewManager _viewManager;

  const _TypeChip({
    required ClothItemCompoundViewManager viewManager,
    required ClothItemType type,
  })  : _viewManager = viewManager,
        _type = type;

  @override
  String get _label => clothItemTypeDisplayOptions[_type]!.text;

  @override
  Widget _avatar(BuildContext context) =>
      SvgPicture.asset(ClothItemTypeIconQuerier(context, _type).icon);

  @override
  void _removeFilter() {
    _viewManager.removeFilteredType(_type);
  }
}

abstract class _FilterChip extends StatelessWidget {
  const _FilterChip();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _removeFilter,
      child: Chip(
        label: Text(_label),
        avatar: _avatar(context),
        visualDensity: VisualDensity.compact,
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        deleteIcon: const Icon(Icons.cancel),
        onDeleted: _removeFilter,
      ),
    );
  }

  String get _label;

  Widget _avatar(BuildContext context);

  void _removeFilter();
}
