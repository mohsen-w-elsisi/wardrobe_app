import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/dispay_options/attribute.dart';

class OutfitMakerAtributeFilterChips extends StatelessWidget {
  final AttributeFIlterManager attributeFIlterManager;

  const OutfitMakerAtributeFilterChips({
    super.key,
    required this.attributeFIlterManager,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListenableBuilder(
        listenable: attributeFIlterManager,
        builder: (_, __) {
          return Wrap(
            spacing: 8,
            children: _attributeFilterChips,
          );
        },
      ),
    );
  }

  List<Widget> get _attributeFilterChips {
    return [
      for (final attribute in ClothItemAttribute.values)
        _AttributeFilterChip(
          attributeFIlterManager: attributeFIlterManager,
          attribute: attribute,
        )
    ];
  }
}

class _AttributeFilterChip extends StatelessWidget {
  final AttributeFIlterManager attributeFIlterManager;
  final ClothItemAttribute attribute;

  const _AttributeFilterChip({
    required this.attributeFIlterManager,
    required this.attribute,
  });

  @override
  Widget build(BuildContext context) {
    return attributeFIlterManager.attributeIsSelected(attribute)
        ? _selectedChip(context)
        : _unselectedChip;
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

  Widget get _label => Text(clothItemAttributeDisplayOptions[attribute]!.name);
  Widget get _avatar => Icon(clothItemAttributeDisplayOptions[attribute]!.icon);

  void _select() {
    attributeFIlterManager.selectAttribute(attribute);
  }

  void _unselect() {
    attributeFIlterManager.unSelectAttribute(attribute);
  }
}

class AttributeFIlterManager extends ChangeNotifier {
  final Set<ClothItemAttribute> _selectedAttributes = {};

  bool attributeIsSelected(ClothItemAttribute attribute) {
    return _selectedAttributes.contains(attribute);
  }

  void selectAttribute(ClothItemAttribute attribute) {
    _selectedAttributes.add(attribute);
    notifyListeners();
  }

  void unSelectAttribute(ClothItemAttribute attribute) {
    _selectedAttributes.remove(attribute);
    notifyListeners();
  }

  Set<ClothItemAttribute> get selectedAttributes =>
      Set.unmodifiable(_selectedAttributes);
}
