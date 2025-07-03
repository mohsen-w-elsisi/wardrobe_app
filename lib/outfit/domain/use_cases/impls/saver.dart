import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';

import 'utils.dart';

class OutfitSaverImpl extends OutfitSaver with OutfitUseCaseUtils {
  @override
  void save(Outfit outfit) {
    assertNotEphemiral(outfit);
    datagateway.saveOutfit(outfit);
    notifyUi();
  }
}
