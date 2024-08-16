import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/dispay_options/attribute.dart';
import 'package:wardrobe_app/subbmitable_bottom_sheet.dart';
import 'settings.dart';

class ClothItemCompoundViewAttributeFilterModal extends StatelessWidget {
  final ClothItemCompoundViewSettingsController settingsController;
  late final _FilteredAttributeModalManager _filteredAttributeManager;

  ClothItemCompoundViewAttributeFilterModal({
    super.key,
    required this.settingsController,
  }) {
    _filteredAttributeManager = _FilteredAttributeModalManager(
      settingsController.settings.filteredAttributes,
    );
  }

  void show(BuildContext context) {
    showModalBottomSheet(context: context, builder: (_) => this);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _filteredAttributeManager,
      builder: (context, _) => SubbmitableBottomSheet(
        context: context,
        title: "filter by attribute",
        builder: _attributeCheckboxes,
        onSubmit: _saveSelectionToSettingsController,
        submitButtonText: "filter",
      ),
    );
  }

  Widget _attributeCheckboxes(context) {
    return Column(
      children: [
        for (final attribute in ClothItemAttribute.values)
          _AttributeLabeledCheckBox(
            attribute: attribute,
            filteredAttributeModalManager: _filteredAttributeManager,
          )
      ],
    );
  }

  void _saveSelectionToSettingsController() {
    settingsController.setFilteredAttributes(
      _filteredAttributeManager.set,
    );
  }
}

class _AttributeLabeledCheckBox extends StatelessWidget {
  final ClothItemAttribute attribute;
  final _FilteredAttributeModalManager filteredAttributeModalManager;

  const _AttributeLabeledCheckBox({
    required this.attribute,
    required this.filteredAttributeModalManager,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: filteredAttributeModalManager.attributeIsSelected(attribute),
          onChanged: updateAttributeSelectionState,
        ),
        Text(_attributeName)
      ],
    );
  }

  void updateAttributeSelectionState(isSelected) {
    if (isSelected ?? false) {
      filteredAttributeModalManager.addAttribute(attribute);
    } else {
      filteredAttributeModalManager.removeAttribute(attribute);
    }
  }

  String get _attributeName =>
      clothItemAttributeDisplayOptions[attribute]!.name;
}

class _FilteredAttributeModalManager with ChangeNotifier {
  late final Set<ClothItemAttribute> _selectedAttributes;

  _FilteredAttributeModalManager(Set<ClothItemAttribute> selectedAttributes) {
    _selectedAttributes = selectedAttributes.toSet();
  }

  void addAttribute(ClothItemAttribute attribute) {
    _selectedAttributes.add(attribute);
    notifyListeners();
  }

  void removeAttribute(ClothItemAttribute attribute) {
    _selectedAttributes.remove(attribute);
    notifyListeners();
  }

  bool attributeIsSelected(ClothItemAttribute attribute) {
    return _selectedAttributes.contains(attribute);
  }

  Set<ClothItemAttribute> get set => Set.unmodifiable(_selectedAttributes);
}
