import 'cloth_item.dart';
import 'manager.dart';

class ClothItemQuerierImpl implements ClothItemQuerier {
  final Map<String, ClothItem> _items;

  ClothItemQuerierImpl({
    required List<ClothItem> items,
  }) : _items = {for (final item in items) item.id: item};

  @override
  List<ClothItem> get cltohItems => List.unmodifiable(_items.values);

  @override
  List<ClothItem> matchingItemsOf(ClothItem item) {
    return [
      for (final matchingItemId in item.matchingItems) getById(matchingItemId)
    ].nonNulls.toList();
  }

  @override
  ClothItem? getById(String id) {
    return _items[id];
  }

  @override
  void registerItem(ClothItem item) {
    _items[item.id] = item;
  }

  @override
  void removeItem(ClothItem item) {
    _items.remove(item.id);
  }

  @override
  void deleteAllItems() {
    _items.clear();
  }
}
