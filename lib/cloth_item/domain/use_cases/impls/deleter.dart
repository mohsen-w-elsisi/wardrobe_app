import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

import 'use_case_utils.dart';

class ClothItemDeleterImpl extends ClothItemDeleter with UseCaseUtils {
  @override
  void delete(ClothItem item) {
    dataGateway.delete(item.id);
    notifyUi();
  }

  @override
  void clearWardrobe() {
    dataGateway.deleteAll();
    notifyUi();
  }
}
