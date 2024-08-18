import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/dispay_options/attribute.dart';
import 'package:wardrobe_app/subbmitable_bottom_sheet.dart';
import '../../backend/attribute_selection_manager.dart';
import 'settings.dart';

class ClothItemCompoundViewAttributeFilterModal extends StatelessWidget {
  final ClothItemCompoundViewSettingsController settingsController;
  late final ClothItemAttributeSelectionManager _filteredAttributeManager;

  ClothItemCompoundViewAttributeFilterModal({
    super.key,
    required this.settingsController,
  }) {
    _filteredAttributeManager = ClothItemAttributeSelectionManager(
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
      builder: (context, _) => SubmitableBottomSheet(
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
      _filteredAttributeManager.selectedAttributes,
    );
  }
}

class _AttributeLabeledCheckBox extends StatelessWidget {
  final ClothItemAttribute attribute;
  final ClothItemAttributeSelectionManager filteredAttributeModalManager;

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
      filteredAttributeModalManager.selectAttribute(attribute);
    } else {
      filteredAttributeModalManager.unselectAttribute(attribute);
    }
  }

  String get _attributeName =>
      clothItemAttributeDisplayOptions[attribute]!.name;
}
