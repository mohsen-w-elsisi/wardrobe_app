import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/shared/entities/season.dart';
import 'package:wardrobe_app/shared/use_cases/use_cases.dart';

class ClothItemQuerierImpl extends ClothItemQuerier with UseCaseUtils {
  @override
  Future<List<ClothItem>> getAll() async {
    return (await dataGateway.getAllItems()).toList();
  }

  @override
  Future<List<ClothItem>> getAllofCurrentSeason() async {
    final allItems = await dataGateway.getAllItems();
    final season = await GetIt.I<SeasonGetter>().currentSeason();
    if (season == Season.all) {
      return allItems.toList();
    } else {
      return [
        for (final item in allItems)
          if (item.season == season || item.season == Season.all) item
      ];
    }
  }

  @override
  Future<ClothItem> getById(String id) async => dataGateway.getById(id);

  @override
  Future<bool> itemExists(String id) async {
    try {
      await dataGateway.getById(id);
      return true;
    } on StateError {
      return false;
    }
  }
}
