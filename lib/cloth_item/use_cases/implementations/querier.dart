import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemQuerierImpl extends ClothItemQuerier with UseCaseUtils {
  @override
  List<ClothItem> getAll() {
    return dataGateway.getAllItems().toList();
  }

  @override
  ClothItem getById(String id) {
    return dataGateway.getById(id);
  }
}
