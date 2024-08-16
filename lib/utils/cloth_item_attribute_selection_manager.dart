import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';

class ClothItemAttributeSelectionManager with ChangeNotifier {
  late final Set<ClothItemAttribute> _selectedAttributes;

  ClothItemAttributeSelectionManager(
      Set<ClothItemAttribute> selectedAttributes) {
    _selectedAttributes = selectedAttributes.toSet();
  }

  void selectAttribute(ClothItemAttribute attribute) {
    _selectedAttributes.add(attribute);
    notifyListeners();
  }

  void unselectAttribute(ClothItemAttribute attribute) {
    _selectedAttributes.remove(attribute);
    notifyListeners();
  }

  bool attributeIsSelected(ClothItemAttribute attribute) {
    return _selectedAttributes.contains(attribute);
  }

  Set<ClothItemAttribute> get selectedAttributes =>
      Set.unmodifiable(_selectedAttributes);
}
