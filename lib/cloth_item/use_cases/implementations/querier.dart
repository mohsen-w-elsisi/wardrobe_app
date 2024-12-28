import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemQuerierImpl extends ClothItemQuerier {
  @override
  List<ClothItem> getAll() {
    return _dataGateway.getAllItems().toList();
  }

  @override
  ClothItem getById(String id) {
    return _dataGateway.getById(id);
  }

  ClothItemDataGateway get _dataGateway => GetIt.I<ClothItemDataGateway>();
}
