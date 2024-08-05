import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views_utils.dart';

final ClothItemSortModeDisplayOptions clothItemSortModeDisplayOption = {
  ClothItemSortMode.byName: ClothItemSortModeDisplayOption(
    text: "name",
    sortingFunction: _sortItemsByName,
  ),
  ClothItemSortMode.byDateCreated: ClothItemSortModeDisplayOption(
    text: "date created",
    sortingFunction: _sortItemsByDateCreated,
  ),
};

typedef ClothItemSortModeDisplayOptions
    = Map<ClothItemSortMode, ClothItemSortModeDisplayOption>;

ClothItemSorter _sortItemsByName = (a, b) {
  final nameOfA = a.name;
  final nameOfB = b.name;
  return nameOfA.compareTo(nameOfB);
};

ClothItemSorter _sortItemsByDateCreated = (a, b) {
  final timeOfA = a.dateCreated.millisecondsSinceEpoch;
  final timeOfB = b.dateCreated.millisecondsSinceEpoch;
  return timeOfA.compareTo(timeOfB);
};

class ClothItemSortModeDisplayOption {
  final String text;
  final ClothItemSorter sortingFunction;

  const ClothItemSortModeDisplayOption({
    required this.text,
    required this.sortingFunction,
  });
}

typedef ClothItemSorter = int Function(ClothItem a, ClothItem b);
