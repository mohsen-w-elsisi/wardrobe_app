import 'package:flutter/foundation.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

class OutfitMakerManager extends ChangeNotifier
    with _StepController, _SelectedItemRegistry {
  bool _isInitialised = false;

  OutfitMakerManager({
    List<ClothItem>? avaliableItems,
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
}

mixin _StepController on ChangeNotifier {
  Function()? onLastStepDone;

  int _currentStep = 0;

  int get currentStep => _currentStep;

  set currentStep(int input) {
    _currentStep = input;
    notifyListeners();
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

  bool get isOnLastStep => currentStep == ClothItemType.values.length - 1;
  bool get isOnFirstStep => currentStep == 0;

  ClothItemType get typeOfCurrentStep => ClothItemType.values[currentStep];
}

mixin _SelectedItemRegistry on ChangeNotifier {
  final Map<ClothItemType, ClothItem?> _selectedItems = {
    for (final type in ClothItemType.values) type: null
  };

  late List<ClothItem> _avaliableItems;

  void setAvailableItems(List<ClothItem> newAvailableItems) {
    _avaliableItems = newAvailableItems;
    clearAllSelectedItems();
    notifyListeners();
  }

  void clearAllSelectedItems() {
    for (final item in selectedItemsAsList) {
      clearSelectedItemOfType(item.type);
    }
  }

  List<ClothItem> validItemsOfType(ClothItemType type) {
    return ClothItemOrganiser(_avaliableItems)
        .itemsMatchingWithBaseitemsOfType(selectedItemsAsList, type);
  }

  bool itemOfTypeIsSelected(ClothItemType type) {
    return selectedItems[type] != null;
  }

  Map<ClothItemType, ClothItem?> get selectedItems {
    return Map.unmodifiable(_selectedItems);
  }

  void setSelectedItem(ClothItem item) {
    _selectedItems[item.type] = item;
    notifyListeners();
  }

  void clearSelectedItemOfType(ClothItemType type) {
    _selectedItems[type] = null;
    notifyListeners();
  }

  bool get notEnoughItemsSelected => selectedItemsAsList.length < 2;

  List<ClothItem> get selectedItemsAsList {
    return selectedItems.values.nonNulls.toList();
  }
}
