import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/shared/entities/season.dart';

class OutfitSeasonCalculator {
  final Iterable<String> _clothItemIds;
  late final Iterable<ClothItem> _clothItems;
  late final bool _hasSummer;
  late final bool _hasWinter;
  late final Season _commonSeason;

  OutfitSeasonCalculator(Outfit outfit) : _clothItemIds = outfit.items;

  Future<Season> season() async {
    await _fetchClothItems();
    _extractItemSeasons();
    _findCommonSeason();
    return _commonSeason;
  }

  Future<void> _fetchClothItems() async {
    _clothItems = [
      for (final id in _clothItemIds)
        await GetIt.I<ClothItemQuerier>().getById(id)
    ];
  }

  void _extractItemSeasons() {
    final itemSeasons = {for (final item in _clothItems) item.season};
    _hasSummer = itemSeasons.contains(Season.summer);
    _hasWinter = itemSeasons.contains(Season.winter);
  }

  void _findCommonSeason() {
    if (_hasSummer && _hasWinter) {
      _commonSeason = Season.all;
    } else if (_hasSummer) {
      _commonSeason = Season.summer;
    } else if (_hasWinter) {
      _commonSeason = Season.winter;
    } else {
      _commonSeason = Season.all;
    }
  }
}
