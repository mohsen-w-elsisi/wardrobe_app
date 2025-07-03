import 'package:flutter/foundation.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

class OutfitMakerManager with ChangeNotifier {
  late List<ClothItem> _avaliableItems;
  bool _isInitialised = false;

  int _currentStep = 0;

  final Map<ClothItemType, ClothItem?> _selectedItems = {
    for (final type in ClothItemType.values) type: null
  };

  Function()? onLastStepDone;

  OutfitMakerManager({
    List<ClothItem>? avaliableItems,
    this.onLastStepDone,
  }) {
    if (avaliableItems != null) {
      _avaliableItems = avaliableItems;
      _isInitialised = true;
    }
  }

  bool get isInitialised => _isInitialised;

  void initialiseAvailableItems(List<ClothItem> avaliableItems) {
    assert(!_isInitialised, "OutfitMakerManager is already initialised");
    _isInitialised = true;
    setAvailableItems(avaliableItems);
    notifyListeners();
  }

  void setAvailableItems(List<ClothItem> newAvailableItems) {
    _assertIsInitalised();
    _avaliableItems = newAvailableItems;
    currentStep = 0;
    clearAllSelectedItems();
    notifyListeners();
  }

  void clearAllSelectedItems() {
    _assertIsInitalised();
    for (final item in selectedItemsAsList) {
      clearSelectedItemOfType(item.type);
    }
  }

  void nextStep() {
    if (isOnLastStep) {
      if (onLastStepDone != null) onLastStepDone!();
    } else {
      currentStep++;
    }
  }

  void previousStep() {
    if (isOnLastStep) {
      return;
    } else {
      currentStep -= 1;
    }
  }

  List<ClothItem> validItemsOfType(ClothItemType type) {
    _assertIsInitalised();
    return ClothItemOrganiser(_avaliableItems)
        .itemsMatchingWithBaseitemsOfType(selectedItemsAsList, type);
  }

  int get currentStep => _currentStep;

  set currentStep(int input) {
    _currentStep = input;
    notifyListeners();
  }

  bool get isOnLastStep => currentStep == ClothItemType.values.length - 1;
  bool get isOnFirstStep => currentStep == 0;

  bool itemOfTypeIsSelected(ClothItemType type) {
    _assertIsInitalised();
    return selectedItems[type] != null;
  }

  Map<ClothItemType, ClothItem?> get selectedItems {
    _assertIsInitalised();
    return Map.unmodifiable(_selectedItems);
  }

  void setSelectedItem(ClothItem item) {
    _assertIsInitalised();
    _selectedItems[item.type] = item;
    notifyListeners();
  }

  void clearSelectedItemOfType(ClothItemType type) {
    _assertIsInitalised();
    _selectedItems[type] = null;
    notifyListeners();
  }

  ClothItemType get typeOfCurrentStep => ClothItemType.values[currentStep];

  bool get notEnoughItemsSelected => selectedItemsAsList.length < 2;

  List<ClothItem> get selectedItemsAsList {
    _assertIsInitalised();
    return selectedItems.values.nonNulls.toList();
  }

  void _assertIsInitalised() {
    assert(_isInitialised, "OutfitMakerManager is not initialised");
  }
}
