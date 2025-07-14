import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/outfit/presentation/screens/maker_screen/manager.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/attribute_selection_manager.dart';

import 'attribute_filter_chips.dart';
import 'stepper.dart';

class OutfitMakerScreen extends StatefulWidget {
  final List<ClothItem>? preSelectedItems;

  OutfitMakerScreen({this.preSelectedItems, super.key}) {}

  @override
  State<OutfitMakerScreen> createState() => _OutfitMakerScreenState();
}

class _OutfitMakerScreenState extends State<OutfitMakerScreen> {
  final _clothItemQuerier = GetIt.I<ClothItemQuerier>();
  final _attributeFilterationManager = ClothItemAttributeSelectionManager({});
  final _outfitMakerManager = OutfitMakerManager();

  late List<ClothItem> _allSavedItems;

  @override
  void initState() {
    _fetchSavedItems().whenComplete(_initOutfitMakerManager);
    super.initState();
  }

  Future<void> _fetchSavedItems() async {
    _allSavedItems = await _clothItemQuerier.getAll();
  }

  void _initOutfitMakerManager() {
    _outfitMakerManager.initialiseAvailableItems(_allSavedItems);
    _registerPreSelectedItemsWithOutfitMakerManager();
    _listenToUiToUpdateMakerManager();
  }

  void _registerPreSelectedItemsWithOutfitMakerManager() {
    if (widget.preSelectedItems != null) {
      widget.preSelectedItems!.forEach(_outfitMakerManager.setSelectedItem);
    }
  }

  void _listenToUiToUpdateMakerManager() {
    _attributeFilterationManager.addListener(_updateFilterAttrInMakerManager);
    GetIt.I<ClothItemUiNotifier>().addListener(_reloadAllItemsIntoMakerManager);
  }

  void _updateFilterAttrInMakerManager() {
    _outfitMakerManager.filterByAttributes(
      _attributeFilterationManager.selectedAttributes,
    );
  }

  void _reloadAllItemsIntoMakerManager() async {
    final allItems = await GetIt.I<ClothItemQuerier>().getAll();
    _outfitMakerManager.setAvailableItems(allItems);
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _outfitMakerManager,
      builder: (_, __) =>
          _outfitMakerManager.isInitialised ? _screenUi : Container(),
    );
  }

  Widget get _screenUi {
    return _ScreenUi(
      outfitMakerManager: _outfitMakerManager,
      attributeFilterationManager: _attributeFilterationManager,
    );
  }
}

class _ScreenUi extends StatelessWidget {
  final OutfitMakerManager outfitMakerManager;
  final ClothItemAttributeSelectionManager attributeFilterationManager;

  const _ScreenUi({
    required this.outfitMakerManager,
    required this.attributeFilterationManager,
  });

  @override
  Widget build(BuildContext context) {
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
  }

  AppBar get _appBar {
    return AppBar(
      title: const Text("outfit maker"),
    );
  }

  Widget get _stepper {
    return OutfitMakerStepper(
      outfitMakerManager: outfitMakerManager,
    );
  }

  Widget get _attributeFilterChips {
    return OutfitMakerAtributeFilterChips(
      selectionManager: attributeFilterationManager,
    );
  }

  Widget get _skipToPreviewButton {
    return Visibility(
      visible: !(outfitMakerManager.notEnoughItemsSelected),
      child: FloatingActionButton(
        tooltip: "preview outfit",
        onPressed: () => outfitMakerManager.onLastStepDone!(),
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
