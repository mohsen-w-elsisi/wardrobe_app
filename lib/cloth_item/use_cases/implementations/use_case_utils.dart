import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

mixin UseCaseUtils {
  ClothItemDataGateway get dataGateway => GetIt.I<ClothItemDataGateway>();

  void notifyUi() {
    final uiNotifier = GetIt.I<ClothItemUiNotifier>();
    uiNotifier.notifyUi();
  }
}
