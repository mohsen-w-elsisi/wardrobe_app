import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

import 'data_gateway_access.dart';

class ClothItemDeleterImpl extends ClothItemDeleter with ClothItemDataAccess {
  @override
  void delete(ClothItem item) {
    dataGateway.delete(item.id);
  }

  @override
  void clearWardrobe() => dataGateway.deleteAll();
}
