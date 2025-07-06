import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';

import 'utils.dart';

class OutfitDeleterImpl extends OutfitDeleter with OutfitUseCaseUtils {
  @override
  void delete(Outfit outfit) {
    _assertNonEphemeral(outfit);
    datagateway.delete(outfit);
    notifyUi();
  }

  void _assertNonEphemeral(Outfit outfit) {
    assert(!outfit.isEphemiral, 'Cannot delete an ephemeral outfit.');
  }
}
