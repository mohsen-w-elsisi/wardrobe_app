import 'package:wardrobe_app/cloth_item_views/cloth_item_sort_mode_display_options.dart';
import 'package:wardrobe_app/cloth_item_views/cloth_item_views_utils.dart';

import 'cloth_item.dart';

class ClothItemOrganiser {
  final List<ClothItem> clothItems;

  const ClothItemOrganiser(this.clothItems);

  List<ClothItem> get tops => filterBytype(ClothItemType.top);
  List<ClothItem> get bottoms => filterBytype(ClothItemType.bottom);
  List<ClothItem> get jackets => filterBytype(ClothItemType.jacket);

  List<ClothItem> filterBytype(ClothItemType type) {
    return [
      for (final item in clothItems)
        if (item.type == type) item
    ];
  }

  List<ClothItem> sort(ClothItemSortMode sortMode) {
    final sortingFuncion = _sortingFunctionOfMode(sortMode);
    final copiedList = _copyList();
    copiedList.sort(sortingFuncion);
    return copiedList;
  }

  ClothItemSorter _sortingFunctionOfMode(ClothItemSortMode sortMode) =>
      clothItemSortModeDisplayOption[sortMode]!.sortingFunction;

  List<ClothItem> _copyList() => [...clothItems];
}
