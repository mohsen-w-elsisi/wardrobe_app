import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/outfit/presentation/screens/maker_screen/manager.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/attribute_selection_manager.dart';

import 'attribute_filter_chips.dart';
import 'stepper.dart';

class OutfitMakerScreen extends StatelessWidget {
  final _clothItemQuerier = GetIt.I<ClothItemQuerier>();
  final _attributeFilterationManager = ClothItemAttributeSelectionManager({});
  final _outfitMakerManager = OutfitMakerManager();

  late List<ClothItem> _allSavedItems;

  OutfitMakerScreen({List<ClothItem>? preSelectedItems, super.key}) {
    _initOutfitMakerManager().whenComplete(() {
      _registerPreSelectedItemsWithOutfitMakerManager(preSelectedItems);
      _listenToChangesInFilteredAttributesAndUpdateAvailableItems();
    });
  }

  Future<void> _initOutfitMakerManager() async {
    await _fetchSavedItems();
    _outfitMakerManager.initialiseAvailableItems(_allSavedItems);
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
    _outfitMakerManager.filterByAttributes(
      _attributeFilterationManager.selectedAttributes,
    );
  }

  List<ClothItem> _getItemsFilteredBySelectedAttributes() {
    final organiser = ClothItemOrganiser(_allSavedItems);
    final filterAttributes = _attributeFilterationManager.selectedAttributes;
    return organiser.filterUsingAttributes(filterAttributes);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _outfitMakerManager,
      builder: (_, __) {
        return Scaffold(
          appBar: _appBar,
          body: ListView(
            children: [
              _attributeFilterChips,
              _stepper,
            ],
          ),
          floatingActionButton: _skipToPreviewButton,
        );
      },
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

  Widget get _skipToPreviewButton {
    return Visibility(
      visible: !(_outfitMakerManager.notEnoughItemsSelected),
      child: FloatingActionButton(
        tooltip: "preview outfit",
        onPressed: () => _outfitMakerManager.onLastStepDone!(),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }

  Future<void> _fetchSavedItems() async {
    _allSavedItems = await _clothItemQuerier.getAll();
  }
}
