import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/outfit/domain/data_gateway.dart';
import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/domain/outfit_season_calculator.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/impls/utils.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/shared/entities/season.dart';
import 'package:wardrobe_app/shared/use_cases/use_cases.dart';

class OutfitQuerierImpl extends OutfitQuerier with OutfitUseCaseUtils {
  @override
  Iterable<Outfit> getAll() => datagateway.getAll();

  @override
  Future<Iterable<Outfit>> getAllOfCurrentSeason() =>
      _CurrentSeasonOutiftGetter().get();

  @override
  Outfit getById(String id) {
    return datagateway.getById(id);
  }

  @override
  bool outfitExists(Outfit outfit) {
    if (outfit.isEphemiral) return false;
    return datagateway.outfitIsSaved(outfit);
  }
}

class _CurrentSeasonOutiftGetter {
  late final Season seaon;
  late Iterable<Outfit> outfits;

  Future<Iterable<Outfit>> get() async {
    await _getSeason();
    await _getAllOutfits();
    if (seaon != Season.all) await _filterOutfits();
    return outfits;
  }

  Future<void> _getSeason() async {
    seaon = await GetIt.I<SeasonGetter>().currentSeason();
  }

  Future<void> _getAllOutfits() async {
    outfits = GetIt.I<OutfitDataGateway>().getAll();
  }

  Future<void> _filterOutfits() async {
    for (final outfit in outfits) {
      final outfitSeason = await OutfitSeasonCalculator(outfit).season();
      if (outfitSeason != seaon) _removeOutfit(outfit);
    }
  }

  void _removeOutfit(Outfit badOutfit) {
    outfits = [
      for (final outfit in outfits)
        if (outfit.id != badOutfit.id) outfit
    ];
  }
}
