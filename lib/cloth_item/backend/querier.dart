import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class ClothItemQuerierImpl implements ClothItemQuerier {
  List<ClothItem> _items;

  ClothItemQuerierImpl({
    required List<ClothItem> items,
  }) : _items = items;

  @override
  List<ClothItem> get cltohItems => List.unmodifiable(_items);

  @override
  List<ClothItem> matchingItemsOf(ClothItem item) {
    return _items.where(item.isMatchingItem).toList();
  }

  @override
  ClothItem? getById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } on StateError {
      return null;
    }
  }

  @override
  bool itemIsRegistered(ClothItem item) {
    return _items.indexWhere(item.hasSameIdAs) >= 0;
  }

  @override
  void registerItem(ClothItem item) {
    if (itemIsRegistered(item)) {
      final index = _indexOf(item);
      _items[index] = item;
    } else {
      _items.add(item);
    }
  }

  @override
  void removeItem(ClothItem item) {
    final index = _indexOf(item);
    _items.removeAt(index);
  }

  @override
  void deleteAllItems() {
    _items = [];
  }

  int _indexOf(ClothItem item) {
    if (itemIsRegistered(item)) {
      return _items.indexWhere(item.hasSameIdAs);
    } else {
      throw StateError("${item.name} not registered");
    }
  }
}
