import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class CLothItemDifferImpl implements ClothItemDiffer {
  final List<ClothItem> storedItems;
  final List<ClothItem> currentItems;

  final List<ClothItem> _editedItems = [];
  final List<ClothItem> _deletedItems = [];
  final List<ClothItem> _newItems = [];

  CLothItemDifferImpl({
    required this.storedItems,
    required this.currentItems,
  }) {
    _findEditedItems();
    _findDeletedItems();
    _findNewItems();
  }

  void _findEditedItems() {
    for (final currentItem in currentItems) {
      if (_isCommonItem(currentItem)) {
        if (_itemWasEdited(currentItem)) {
          _editedItems.add(currentItem);
        }
      }
    }
  }

  bool _isCommonItem(ClothItem item) {
    return !(_itemNotInStoredItems(item)) && !(_itemNotInCurrentItems(item));
  }

  bool _itemWasEdited(ClothItem currentItem) {
    final matchingStoredItem = storedItems.firstWhere(currentItem.hasSameIdAs);
    return currentItem != matchingStoredItem;
  }

  void _findDeletedItems() {
    for (final storedItem in storedItems) {
      if (_itemNotInCurrentItems(storedItem)) _deletedItems.add(storedItem);
    }
  }

  bool _itemNotInCurrentItems(ClothItem item) {
    try {
      currentItems.firstWhere(item.hasSameIdAs);
      return false;
    } on StateError {
      return true;
    }
  }

  void _findNewItems() {
    for (final currentItem in currentItems) {
      if (_itemNotInStoredItems(currentItem)) _newItems.add(currentItem);
    }
  }

  bool _itemNotInStoredItems(ClothItem item) {
    try {
      storedItems.firstWhere(item.hasSameIdAs);
      return false;
    } on StateError {
      return true;
    }
  }

  @override
  List<ClothItem> get deletedItems => List.unmodifiable(_deletedItems);
  @override
  List<ClothItem> get editedItems => List.unmodifiable(_editedItems);
  @override
  List<ClothItem> get newItems => List.unmodifiable(_newItems);
}
