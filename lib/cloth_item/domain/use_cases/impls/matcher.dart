import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

class ClothItemMatcherImpl extends ClothItemMatcher {
  @override
  Future<List<ClothItem>> findMatchingItems(ClothItem item) async {
    return [
      for (final testItem in (await _allItems))
        if (item.matchingItems.contains(testItem.id)) testItem
    ];
  }

  Future<List<ClothItem>> get _allItems async =>
      GetIt.I<ClothItemQuerier>().getAll();

  @override
  Future<List<ClothItem>> findMatchingItemsOfSeason(ClothItem item) async {
    return [
      for (final testItem in await _allItemsOfSeason)
        if (item.matchingItems.contains(testItem.id)) testItem
    ];
  }

  Future<List<ClothItem>> get _allItemsOfSeason =>
      GetIt.I<ClothItemQuerier>().getAllofCurrentSeason();
}
