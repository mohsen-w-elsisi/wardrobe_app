import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemFavouriteTogglerImpl extends ClothItemFavouriteToggler {
  @override
  void toggleItem(ClothItem item) {
    _assertItemExists(item);
    final alteredItem = _toggleFavourite(item);
    _save(alteredItem);
  }

  void _assertItemExists(ClothItem item) {
    // will throw StateError if item not found
    GetIt.I<ClothItemQuerier>().getById(item.id);
  }

  ClothItem _toggleFavourite(ClothItem item) =>
      item.copyWith(isFavourite: !item.isFavourite);

  void _save(ClothItem item) => GetIt.I<ClothItemSaver>().save(item);
}
