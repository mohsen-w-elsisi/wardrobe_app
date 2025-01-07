import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemMatcherImpl extends ClothItemMatcher {
  @override
  List<ClothItem> findMatchingItems(ClothItem item) {
    return [
      for (final testItem in _allItems)
        if (item.matchingItems.contains(testItem.id)) testItem
    ];
  }

  List<ClothItem> get _allItems => GetIt.I<ClothItemQuerier>().getAll();
}
