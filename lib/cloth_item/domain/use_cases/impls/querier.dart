import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/use_case_utils.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

class ClothItemQuerierImpl extends ClothItemQuerier with UseCaseUtils {
  @override
  Future<List<ClothItem>> getAll() async {
    return (await dataGateway.getAllItems()).toList();
  }

  @override
  Future<ClothItem> getById(String id) async => dataGateway.getById(id);

  @override
  Future<bool> itemExists(String id) async {
    try {
      await dataGateway.getById(id);
      return true;
    } on StateError {
      return false;
    }
  }
}
