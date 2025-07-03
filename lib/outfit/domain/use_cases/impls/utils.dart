import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/outfit/domain/data_gateway.dart';
import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/domain/ui_notifier.dart';

mixin OutfitUseCaseUtils {
  OutfitDataGateway get datagateway => GetIt.I<OutfitDataGateway>();

  void notifyUi() => GetIt.I<OutfitUiNotifier>().notify();

  void assertNotEphemiral(Outfit outfit) {
    assert(
      !outfit.isEphemiral,
      'Cannot perform operation on an ephemeral outfit.',
    );
  }
}
