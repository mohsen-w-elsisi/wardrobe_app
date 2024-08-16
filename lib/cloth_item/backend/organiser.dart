import 'package:wardrobe_app/cloth_item/dispay_options/sort_mode.dart';

import 'cloth_item.dart';

class ClothItemOrganiser {
  final List<ClothItem> clothItems;

  const ClothItemOrganiser(this.clothItems);

  List<ClothItem> filterUsingAttributes(Set<ClothItemAttribute> attributes) {
    if (attributes.isEmpty) return clothItems;
    final availableItems = <ClothItem>[];
    for (final item in clothItems) {
      for (final attribute in item.attributes) {
        if (attributes.contains(attribute)) {
          availableItems.add(item);
          break;
        }
      }
    }
    return availableItems;
  }

  List<ClothItem> itemsMatchingWithBaseitemsOfType(
      List<ClothItem> baseItems, ClothItemType type) {
    final clothItemsOfType = filterBytype(type);
    final baseItemNotOfType = ClothItemOrganiser(baseItems).filterOutType(type);

    if (baseItemNotOfType.isEmpty) return clothItemsOfType;

    final itemsMatchingBase = typedMatchingItemsMatrix(baseItemNotOfType, type);

    return _resolveMatchingItemsMatrix(itemsMatchingBase);
  }

  List<ClothItem> _resolveMatchingItemsMatrix(List<List<ClothItem>> matrix) {
    return matrix.length == 1 ? matrix.first : _commonItemsFromLists(matrix);
  }

  List<List<ClothItem>> typedMatchingItemsMatrix(
      List<ClothItem> baseItems, ClothItemType type) {
    final scopedOrganiser = scopeOrganiserToType(type);
    final itemMatrix = scopedOrganiser.matchingItemsMatrix(baseItems);
    return itemMatrix;
  }

  List<List<ClothItem>> matchingItemsMatrix(List<ClothItem> baseItems) {
    return [for (final baseItem in baseItems) itemsMatchingWith(baseItem)];
  }

  List<ClothItem> itemsMatchingWith(ClothItem item) {
    return clothItems.where(item.isMatchingItem).toList();
  }

  ClothItemOrganiser scopeOrganiserToType(ClothItemType type) {
    final itemsOfType = filterBytype(type);
    final scopedOrganiser = ClothItemOrganiser(itemsOfType);
    return scopedOrganiser;
  }

  List<ClothItem> filterOutType(ClothItemType type) {
    return [
      for (final item in clothItems)
        if (item.type != type) item
    ];
  }

  List<ClothItem> filterBytype(ClothItemType type) {
    return [
      for (final item in clothItems)
        if (item.type == type) item
    ];
  }

  List<ClothItem> sortFavouritesFirst(ClothItemSortMode sortMode) {
    final sortedFavouriteItems = ClothItemOrganiser(_favourites).sort(sortMode);
    final sortedNonFavouriteItems =
        ClothItemOrganiser(_nonFavourites).sort(sortMode);
    return [
      ...sortedFavouriteItems,
      ...sortedNonFavouriteItems,
    ];
  }

  List<ClothItem> sort(ClothItemSortMode sortMode) {
    final sortingFuncion = _sortingFunctionOfMode(sortMode);
    final copiedList = _copyList();
    copiedList.sort(sortingFuncion);
    return copiedList;
  }

  ClothItemSorter _sortingFunctionOfMode(ClothItemSortMode sortMode) =>
      clothItemSortModeDisplayOptions[sortMode]!.sortingFunction;

  List<ClothItem> _copyList() => [...clothItems];

  List<ClothItem> get _favourites => [
        for (final item in clothItems)
          if (item.isFavourite) item
      ];

  List<ClothItem> get _nonFavourites => [
        for (final item in clothItems)
          if (!(item.isFavourite)) item
      ];

  List<T> _commonItemsFromLists<T>(List<List<T>> lists) {
    return lists
        .map((e) => e.toSet())
        .reduce((a, b) => a.intersection(b))
        .toList();
  }
}
