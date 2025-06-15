import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/compound_view/settings.dart';

class ClothItemCompoundViewManagerinitialiser {
  static const _defaultSettings = ClothItemCompoundViewSettings();

  late ClothItemCompoundViewManager _viewManager;

  ClothItemCompoundViewManager assembleViewManager() {
    _instantiateViewManager();
    _listenForItemChanges();
    return _viewManager;
  }

  void _instantiateViewManager() {
    _viewManager = ClothItemCompoundViewManager(
      clothItems: _allClothitems(),
      settings: _defaultSettings,
    );
  }

  void _listenForItemChanges() {
    GetIt.I<ClothItemUiNotifier>().addListener(() {
      _viewManager.clothItems = _allClothitems();
    });
  }

  static List<ClothItem> _allClothitems() =>
      GetIt.I<ClothItemQuerier>().getAll();
}
