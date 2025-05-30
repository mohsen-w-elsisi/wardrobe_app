import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/presenters/type_selection_manager.dart';
import 'package:wardrobe_app/cloth_item/views/selectable_attribute_chips.dart';
import 'package:wardrobe_app/cloth_item/views/selectable_type_chips.dart';
import 'package:wardrobe_app/cloth_item/presenters/attribute_selection_manager.dart';
import 'package:wardrobe_app/common_widgets/subbmitable_bottom_sheet.dart';
import 'settings.dart';

class ClothItemCompoundViewFiltersModal extends StatelessWidget {
  final ClothItemCompoundViewManager settingsController;
  late final ClothItemAttributeSelectionManager _filteredAttributeManager;
  late final ClothItemTypeSelectionManager _filteredTypeManager;

  ClothItemCompoundViewFiltersModal({
    super.key,
    required this.settingsController,
  }) {
    _filteredAttributeManager = ClothItemAttributeSelectionManager(
      settingsController.settings.filteredAttributes,
    );
    _filteredTypeManager = ClothItemTypeSelectionManager(
      settingsController.settings.filteredTypes,
    );
  }

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => this,
      isScrollControlled: true,
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height * 0.7,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _filteredAttributeManager,
      builder: (context, _) => SubmitableBottomSheet(
        context: context,
        title: "filters",
        builder: (_) => _modalContent(),
        onSubmit: _saveSelectionToSettingsController,
        submitButtonText: "filter",
      ),
    );
  }

  Widget _modalContent() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FilterSectionTitle("type"),
          ClothItemSelectableTypeChips(
            selectionManager: _filteredTypeManager,
          ),
          const _FilterSectionTitle("attribute"),
          ClothItemSelectableAttributeChips(
            selectionManager: _filteredAttributeManager,
          ),
        ],
      ),
    );
  }

  void _saveSelectionToSettingsController() {
    settingsController.setFilteredAttributes(
      _filteredAttributeManager.selectedAttributes,
    );
    settingsController.setFilteredTypes(
      _filteredTypeManager.selectedTypes,
    );
  }
}

class _FilterSectionTitle extends StatelessWidget {
  const _FilterSectionTitle(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
