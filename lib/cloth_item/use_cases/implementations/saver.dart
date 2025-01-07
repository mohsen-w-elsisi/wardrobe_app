import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemSaverImpl extends ClothItemSaver with UseCaseUtils {
  @override
  void save(ClothItem item) {
    dataGateway.save(item);
    notifyUi();
  }
}
