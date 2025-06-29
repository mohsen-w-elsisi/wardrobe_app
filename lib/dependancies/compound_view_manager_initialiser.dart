import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/compound_view/settings.dart';

class ClothItemCompoundViewManagerinitialiser {
  static const _defaultSettings = ClothItemCompoundViewSettings();

  late ClothItemCompoundViewManager _viewManager;

  Future<ClothItemCompoundViewManager> assembleViewManager() async {
    await _instantiateViewManager();
    await _listenForItemChanges();
    return _viewManager;
  }

  Future<void> _instantiateViewManager() async {
    _viewManager = ClothItemCompoundViewManager(
      clothItems: await _allClothitems(),
      settings: _defaultSettings,
    );
  }

  Future<void> _listenForItemChanges() async {
    GetIt.I<ClothItemUiNotifier>().addListener(() async {
      _viewManager.clothItems = await _allClothitems();
    });
  }

  static Future<List<ClothItem>> _allClothitems() =>
      GetIt.I<ClothItemQuerier>().getAllofCurrentSeason();
}
