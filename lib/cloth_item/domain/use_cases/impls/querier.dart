import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

class ClothItemQuerierImpl extends ClothItemQuerier with UseCaseUtils {
  @override
  List<ClothItem> getAll() {
    return dataGateway.getAllItems().toList();
  }

  @override
  ClothItem getById(String id) {
    return dataGateway.getById(id);
  }

  @override
  bool itemExists(String id) {
    try {
      dataGateway.getById(id);
      return true;
    } on StateError {
      return false;
    }
  }
}
