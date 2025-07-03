import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/impls/utils.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';

class OutfitQuerierImpl extends OutfitQuerier with OutfitUseCaseUtils {
  @override
  Iterable<Outfit> getAll() => datagateway.getAll();

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
