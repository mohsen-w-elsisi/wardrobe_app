import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/manager.dart';
import 'package:wardrobe_app/outfiting/outfit_maker_manager.dart';

import 'attribute_filter_chips.dart';
import 'outfit_maker_stepper.dart';

class OutfitMakerScreen extends StatelessWidget {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final _attributeFilterManager = AttributeFIlterManager();
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
    _attributeFilterManager.addListener(_updateAvailableItems);
  }

  void _updateAvailableItems() {
    if (_attributeFilterManager.selectedAttributes.isNotEmpty) {
      final availableItems = _getAvailableItemForAllowedAttributes();
      _outfitMakerManager.setAvailableItems(availableItems);
    } else {
      _outfitMakerManager.setAvailableItems(_allSavedItems);
    }
  }

  List<ClothItem> _getAvailableItemForAllowedAttributes() {
    final availableItems = <ClothItem>[];
    for (final item in _allSavedItems) {
      for (final attribute in item.attributes) {
        if (_attributeFilterManager.selectedAttributes.contains(attribute)) {
          availableItems.add(item);
          break;
        }
      }
    }
    return availableItems;
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
      attributeFIlterManager: _attributeFilterManager,
    );
  }
}
