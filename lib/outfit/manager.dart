import 'package:flutter/material.dart';

import 'outfit.dart';

class OutfitManager with ChangeNotifier {
  final OutfitStorageAgent _storageAgent;
  late List<Outfit> _outfits;

  OutfitManager({
    required OutfitStorageAgent storageAgent,
  }) : _storageAgent = storageAgent {
    _outfits = storageAgent.presavedOutfits;
  }

  List<Outfit> get outfits => _outfits;

  Outfit getOutfitById(String id) {
    return _outfits.firstWhere(
      (outfit) => outfit.id == id,
    );
  }

  void saveOutfit(Outfit outfit) {
    assertNotEphemiral(outfit);
    if (_outfitIsSaved(outfit)) {
      _overwriteExistingOutfit(outfit);
    } else {
      _saveNewOufit(outfit);
    }
  }

  void _overwriteExistingOutfit(Outfit outfit) {
    final index = _indexOfOutfit(outfit)!;
    _outfits[index] = outfit;
    _storageAgent.saveOutfit(outfit);
    notifyListeners();
  }

  void _saveNewOufit(Outfit outfit) {
    _outfits.add(outfit);
    _storageAgent.saveOutfit(outfit);
    notifyListeners();
  }

  void deleteOutfit(Outfit outfit) {
    assertNotEphemiral(outfit);
    final index = _indexOfOutfit(outfit)!;
    _outfits.removeAt(index);
    _storageAgent.deleteOutfit(outfit);
    notifyListeners();
  }

  void deleteAllOutfits() {
    _outfits = [];
    _storageAgent.deletAllOutfits();
    notifyListeners();
  }

  void assertNotEphemiral(Outfit outfit) {
    assert(!(outfit.isEphemiral));
  }

  bool _outfitIsSaved(Outfit outfit) => _indexOfOutfit(outfit) != null;

  int? _indexOfOutfit(Outfit outfit) {
    final index = _outfits.indexWhere(outfit.hasSameId);
    return index.isNegative ? null : index;
  }
}

abstract class OutfitStorageAgent {
  List<Outfit> get presavedOutfits;
  void saveOutfit(Outfit outfit);
  void deleteOutfit(Outfit outfit);
  void deletAllOutfits();
}
