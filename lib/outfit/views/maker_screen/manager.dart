import 'package:flutter/foundation.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

class OutfitMakerManager with ChangeNotifier {
  List<ClothItem> _avaliableItems;

  int _currentStep = 0;

  final Map<ClothItemType, ClothItem?> _selectedItems = {
    for (final type in ClothItemType.values) type: null
  };

  Function()? onLastStepDone;

  OutfitMakerManager({
    required List<ClothItem> avaliableItems,
    this.onLastStepDone,
  }) : _avaliableItems = avaliableItems;

  void setAvailableItems(List<ClothItem> newAvailableItems) {
    _avaliableItems = newAvailableItems;
    currentStep = 0;
    clearAllSelectedItems();
    notifyListeners();
  }

  void clearAllSelectedItems() {
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

  bool itemOfTypeIsSelected(ClothItemType type) => selectedItems[type] != null;

  Map<ClothItemType, ClothItem?> get selectedItems =>
      Map.unmodifiable(_selectedItems);

  void setSelectedItem(ClothItem item) {
    _selectedItems[item.type] = item;
    notifyListeners();
  }

  void clearSelectedItemOfType(ClothItemType type) {
    _selectedItems[type] = null;
    notifyListeners();
  }

  ClothItemType get typeOfCurrentStep => ClothItemType.values[currentStep];

  bool get notEnoughItemsSelected => selectedItemsAsList.length < 2;

  List<ClothItem> get selectedItemsAsList =>
      selectedItems.values.nonNulls.toList();
}
