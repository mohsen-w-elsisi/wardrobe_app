import 'package:rxdart/rxdart.dart';
import 'cloth_item.dart';

class ClothItemManager {
  static const boxName = "cloth items";
  late final List<ClothItem> _clothItems;
  late final BehaviorSubject<List<ClothItem>> _behaviorSubject;
  final ClothItemStorageAgent storageAgent;

  ClothItemManager({required this.storageAgent}) {
    _clothItems = storageAgent.loadAllClothItems();
    _behaviorSubject = BehaviorSubject.seeded(_clothItems);
  }

  void _updateBehaviourSubject() => _behaviorSubject.add(_clothItems);

  List<ClothItem> get clothItems => _clothItems;

  Stream<List<ClothItem>> get stream => _behaviorSubject.stream;

  void saveNewItem(ClothItem clothItem) {
    storageAgent.saveClothItem(clothItem);
    _clothItems.add(clothItem);
    _updateBehaviourSubject();
  }

  void saveManyNewItems(List<ClothItem> clothItems) {
    storageAgent.saveClothItem(clothItem);
    _clothItems.addAll(clothItems);
    _updateBehaviourSubject();
  }

  ClothItem? getClothItemById(String id) {
    final matchedClothItem = _clothItems.firstWhere(
      (clothItem) => clothItem.id == id,
      orElse: () => ClothItem.blank(),
    );
    return matchedClothItem.id != "" ? matchedClothItem : null;
  }

  List<ClothItem> getMatchingItems(ClothItem clothItem) => _clothItems
      .where(
        (testClothItem) => clothItem.matchingItems.contains(testClothItem.id),
      )
      .toList();
}

abstract class ClothItemStorageAgent {
  List<ClothItem> loadAllClothItems();
  void saveClothItem(ClothItem clothItem);
  void deleteClothItem(ClothItem clothiItem);
  void updateClothItem(ClothItem clothItem);
}
