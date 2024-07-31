import 'package:flutter/foundation.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';

class OutfitMakerManager extends ChangeNotifier {
  int _currentStep = 0;

  final Map<ClothItemType, ClothItem?> _selectedItems = {
    for (final type in ClothItemType.values) type: null
  };

  Function()? onLastStepDone;

  OutfitMakerManager({this.onLastStepDone});

  int get currentStep => _currentStep;

  set currentStep(int input) {
    _currentStep = input;
    notifyListeners();
  }

  bool get isOnLastStep => currentStep == ClothItemType.values.length - 1;
  bool get isOnFirstStep => currentStep == 0;

  Map<ClothItemType, ClothItem?> get selectedItems =>
      Map.unmodifiable(_selectedItems);

  void setSelectedItem(ClothItemType type, ClothItem item) {
    _selectedItems[type] = item;
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
}
