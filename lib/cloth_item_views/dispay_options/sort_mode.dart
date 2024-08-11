import 'package:wardrobe_app/cloth_item/cloth_item.dart';

enum ClothItemSortMode { byName, byDateCreated }

final ClothItemSortModeDisplayOptions clothItemSortModeDisplayOptions = {
  ClothItemSortMode.byName: ClothItemSortModeDisplayOption(
    text: "name",
    sortingFunction: _SortingFunctions.name,
  ),
  ClothItemSortMode.byDateCreated: ClothItemSortModeDisplayOption(
    text: "date created",
    sortingFunction: _SortingFunctions.dateCreated,
  ),
};

typedef ClothItemSortModeDisplayOptions
    = Map<ClothItemSortMode, ClothItemSortModeDisplayOption>;

abstract class _SortingFunctions {
  static ClothItemSorter name = (a, b) {
    final nameOfA = a.name;
    final nameOfB = b.name;
    return nameOfA.compareTo(nameOfB);
  };

  static ClothItemSorter dateCreated = (a, b) {
    final timeOfA = a.dateCreated.millisecondsSinceEpoch;
    final timeOfB = b.dateCreated.millisecondsSinceEpoch;
    return timeOfA.compareTo(timeOfB);
  };
}

class ClothItemSortModeDisplayOption {
  final String text;
  final ClothItemSorter sortingFunction;

  const ClothItemSortModeDisplayOption({
    required this.text,
    required this.sortingFunction,
  });
}

typedef ClothItemSorter = int Function(ClothItem a, ClothItem b);
