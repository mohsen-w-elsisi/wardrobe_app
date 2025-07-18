import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';

import 'use_case_utils.dart';

class ClothItemDeleterImpl extends ClothItemDeleter with UseCaseUtils {
  @override
  void delete(ClothItem item) {
    dataGateway.delete(item.id);
    _deleteOutfitsContaining(item);
    _MatchingItemsEdgeDeleter(item).deleteEdgesToMatchingItems();
    notifyUi();
  }

  void _deleteOutfitsContaining(ClothItem item) {
    final allOutfits = GetIt.I<OutfitQuerier>().getAll();
    for (final outfit in allOutfits) {
      if (outfit.items.contains(item.id)) {
        GetIt.I<OutfitDeleter>().delete(outfit);
      }
    }
  }
}

class _MatchingItemsEdgeDeleter {
  final String _itemId;
  final Iterable<String> _matchingItemsIds;
  late Iterable<ClothItem> _matchingItems;

  _MatchingItemsEdgeDeleter(ClothItem item)
      : _matchingItemsIds = item.matchingItems,
        _itemId = item.id;

  Future<void> deleteEdgesToMatchingItems() async {
    await _fetchMatchingItems();
    _removeEdges();
    _saveUpdatedItems();
  }

  Future<void> _fetchMatchingItems() async {
    _matchingItems = [
      for (final id in _matchingItemsIds)
        await GetIt.I<ClothItemQuerier>().getById(id)
    ];
  }

  void _removeEdges() {
    _matchingItems = [
      for (final item in _matchingItems) _itemWithRemovedEdge(item)
    ];
  }

  ClothItem _itemWithRemovedEdge(ClothItem item) {
    final List<String> newMatchingItemsIds = List.from(item.matchingItems);
    newMatchingItemsIds.remove(_itemId);
    return item.copyWith(
      matchingItems: newMatchingItemsIds,
    );
  }

  void _saveUpdatedItems() {
    for (final item in _matchingItems) {
      GetIt.I<ClothItemSaver>().save(item);
    }
  }
}
