import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';

class ClothItemTypeSelectionManager with ChangeNotifier {
  late final Set<ClothItemType> _selectedTypes;

  ClothItemTypeSelectionManager(Set<ClothItemType> selectedTypes) {
    _selectedTypes = selectedTypes.toSet();
  }

  void selectType(ClothItemType type) {
    _selectedTypes.add(type);
    notifyListeners();
  }

  void unselectType(ClothItemType type) {
    _selectedTypes.remove(type);
    notifyListeners();
  }

  bool typeIsSelected(ClothItemType type) {
    return _selectedTypes.contains(type);
  }

  Set<ClothItemType> get selectedTypes => Set.unmodifiable(_selectedTypes);
}
