import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

mixin ClothItemDataAccess {
  ClothItemDataGateway get dataGateway => GetIt.I<ClothItemDataGateway>();
}
