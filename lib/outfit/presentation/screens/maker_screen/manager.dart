import 'package:flutter/foundation.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

class OutfitMakerManager extends _OufitMakerManagerBase
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

  @override
  bool get stilIsSelectableItems {
    final remainingTypes = availableTypes.sublist(currentStep + 1);
    for (final type in remainingTypes) {
      if (validItemsOfType(type).isNotEmpty) return true;
    }
    return false;
  }
}

mixin _StepController on _OufitMakerManagerBase {
  Function()? onLastStepDone;

  int _currentStep = 0;

  int get currentStep => _currentStep;

  set currentStep(int input) {
    _currentStep = input;
    notifyListeners();
  }

  void nextStep() {
    if (isOnLastStep || !stilIsSelectableItems) {
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

  bool get isOnLastStep => currentStep == availableTypes.length - 1;
  bool get isOnFirstStep => currentStep == 0;

  ClothItemType get typeOfCurrentStep => availableTypes[currentStep];
}

mixin _SelectedItemRegistry on _OufitMakerManagerBase {
  final Map<ClothItemType, ClothItem?> _selectedItems = {
    for (final type in ClothItemType.values) type: null
  };

  Set<ClothItemAttribute> _filterAttributes = <ClothItemAttribute>{};

  void filterByAttributes(Set<ClothItemAttribute> attributes) {
    _filterAttributes = attributes;
    notifyListeners();
  }

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
    final filteredAvailableItems = ClothItemOrganiser(_avaliableItems)
        .filterUsingAttributes(_filterAttributes);
    return ClothItemOrganiser(filteredAvailableItems)
        .itemsMatchingWithBaseitemsOfType(selectedItemsAsList, type);
  }

  bool itemOfTypeIsSelected(ClothItemType type) {
    return selectedItems[type] != null;
  }

  Map<ClothItemType, ClothItem?> get selectedItems {
    return Map.unmodifiable({
      for (final entry in _selectedItems.entries)
        if (availableTypes.contains(entry.key)) entry.key: entry.value
    });
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

abstract class _OufitMakerManagerBase with ChangeNotifier {
  late List<ClothItem> _avaliableItems;

  List<ClothItemType> get availableTypes {
    final typesInAvailableItems =
        {for (final item in _avaliableItems) item.type}.toList();
    typesInAvailableItems.sort(
      (a, b) => a.index.compareTo(b.index),
    );
    return typesInAvailableItems;
  }

  bool get stilIsSelectableItems;
}
