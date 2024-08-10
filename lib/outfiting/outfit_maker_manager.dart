import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_organiser.dart';

class OutfitMakerManager extends ChangeNotifier {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();

  int _currentStep = 0;

  final Map<ClothItemType, ClothItem?> _selectedItems = {
    for (final type in ClothItemType.values) type: null
  };

  Function()? onLastStepDone;

  OutfitMakerManager({this.onLastStepDone});

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
    return ClothItemOrganiser(_clothItemManager.clothItems)
        .itemsMatchingWithBaseitemsOfType(selectedItemsAsList, type);
  }

  int get currentStep => _currentStep;

  set currentStep(int input) {
    _currentStep = input;
    notifyListeners();
  }

  bool get isOnLastStep => currentStep == ClothItemType.values.length - 1;
  bool get isOnFirstStep => currentStep == 0;

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

  List<ClothItem> get selectedItemsAsList =>
      selectedItems.values.nonNulls.toList();
}
