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

  @override
  void clearWardrobe() {
    dataGateway.deleteAll();
    GetIt.I<OutfitDeleter>().deleteAll();
    notifyUi();
  }
}
