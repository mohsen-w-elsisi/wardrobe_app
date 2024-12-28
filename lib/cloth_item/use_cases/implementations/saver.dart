import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/data_gateway_access.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemSaverImpl extends ClothItemSaver with ClothItemDataAccess {
  @override
  void save(ClothItem item) {
    dataGateway.save(item);
  }
}
