import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/manager.dart';
import 'package:wardrobe_app/cloth_item/organiser.dart';
import 'package:wardrobe_app/outfit/maker_screen/manager.dart';
import 'package:wardrobe_app/utils/cloth_item_attribute_selection_manager.dart';

import 'attribute_filter_chips.dart';
import 'stepper.dart';

class OutfitMakerScreen extends StatelessWidget {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final _attributeFilterationManager = ClothItemAttributeSelectionManager({});
  late final OutfitMakerManager _outfitMakerManager;

  OutfitMakerScreen({List<ClothItem>? preSelectedItems, super.key}) {
    _initOutfitMakerManager();
    _registerPreSelectedItemsWithOutfitMakerManager(preSelectedItems);
    _listenToChangesInFilteredAttributesAndUpdateAvailableItems();
  }

  void _initOutfitMakerManager() {
    _outfitMakerManager = OutfitMakerManager(
      avaliableItems: _allSavedItems,
    );
  }

  void _registerPreSelectedItemsWithOutfitMakerManager(
      List<ClothItem>? preSelectedItems) {
    if (preSelectedItems != null) {
      preSelectedItems.forEach(_outfitMakerManager.setSelectedItem);
    }
  }

  void _listenToChangesInFilteredAttributesAndUpdateAvailableItems() {
    _attributeFilterationManager.addListener(_updateAvailableItems);
  }

  void _updateAvailableItems() {
    final availableItems = _getItemsFilteredBySelectedAttributes();
    if (_attributeFilterationManager.selectedAttributes.isNotEmpty) {
      _outfitMakerManager.setAvailableItems(availableItems);
    } else {
      _outfitMakerManager.setAvailableItems(_allSavedItems);
    }
  }

  List<ClothItem> _getItemsFilteredBySelectedAttributes() {
    final organiser = ClothItemOrganiser(_allSavedItems);
    final filterAttributes = _attributeFilterationManager.selectedAttributes;
    return organiser.filterUsingAttributes(filterAttributes);
  }

  List<ClothItem> get _allSavedItems => _clothItemManager.clothItems;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: ListenableBuilder(
        listenable: _clothItemManager,
        builder: (_, __) => ListView(
          children: [
            _attributeFilterChips,
            _stepper,
          ],
        ),
      ),
    );
  }

  AppBar get _appBar {
    return AppBar(
      title: const Text("outfit maker"),
    );
  }

  Widget get _stepper {
    return OutfitMakerStepper(
      outfitMakerManager: _outfitMakerManager,
    );
  }

  Widget get _attributeFilterChips {
    return OutfitMakerAtributeFilterChips(
      selectionManager: _attributeFilterationManager,
    );
  }
}
