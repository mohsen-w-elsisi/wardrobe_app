import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/data_gateway.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/outfit/domain/data_gateway.dart';
import 'package:wardrobe_app/outfit/domain/ui_notifier.dart';
import 'package:wardrobe_app/shared/use_cases/use_cases.dart';

class WardrobeClearerImpl extends WardrobeClearer {
  @override
  Future<void> clear() async {
    await GetIt.I<ClothItemDataGateway>().deleteAll();
    GetIt.I<OutfitDataGateway>().deletAll();
    _notifyUi();
  }

  void _notifyUi() {
    GetIt.I<ClothItemUiNotifier>().notifyUi();
    GetIt.I<OutfitUiNotifier>().notify();
  }
}
