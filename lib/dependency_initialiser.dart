import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wardrobe_app/cloth_item/persistance/data_gateway.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/deleter.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/exporter.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/favourite_toggler.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/importer.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/matcher.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/querier.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/saver.dart';
import 'package:wardrobe_app/cloth_item/use_cases/implementations/ui_notifier.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/views/compound_view/settings.dart';
import 'package:wardrobe_app/outfit/backend/hive_storage_agent.dart';
import 'package:wardrobe_app/outfit/backend/manager.dart';
import 'package:wardrobe_app/theme/shared_preferences_theme_storage_agent.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';

class AppDependencyInitialiser {
  static final List<Dependancy> _dependancies = [
    HiveInitialiser(),
    ClothItemDataGatewayInitialiser(),
    ClothItemUiNotifierInitialiser(),
    ClothItemSaverInitialiser(),
    ClothItemDeleterInitialiser(),
    ClothItemFavouriteTogglerInitialiser(),
    ClothItemQuerierInitialiser(),
    ClothItemMatcherInitialiser(),
    ClothItemExporterInitialiser(),
    ClothItemImporterInitialiser(),
    OutfitManagerInitialiser(),
    CompoundViewManagerInitialiser(),
    ThemeStorageControllerInitialiser(),
  ];

  static Future<void> initiaseDependencies() async {
    for (final dependancy in _dependancies) {
      await dependancy.initialise();
    }
  }
}

class HiveInitialiser implements Dependancy {
  @override
  Future<void> initialise() async {
    await Hive.initFlutter();
  }
}

class OutfitManagerInitialiser
    extends GetItRegisterableDependancy<OutfitManager> {
  @override
  Future<void> _initialise() async {
    final storageAgent = await _createOutfitStorageAgent();
    _dependancy = OutfitManager(storageAgent: storageAgent);
  }

  Future<OutfitStorageAgent> _createOutfitStorageAgent() async {
    final storageAgent = HiveOutfitStorageAgent();
    await storageAgent.initialise();
    return storageAgent;
  }
}

class CompoundViewManagerInitialiser
    extends GetItRegisterableDependancy<ClothItemCompoundViewManager> {
  static const _defaultSettings = ClothItemCompoundViewSettings();

  @override
  Future<void> _initialise() async {
    _createCompoundViewManager();
    _listenForItemChanges();
  }

  void _createCompoundViewManager() {
    _dependancy = ClothItemCompoundViewManager(
      clothItems: GetIt.I<ClothItemQuerier>().getAll(),
      settings: _defaultSettings,
    );
  }

  void _listenForItemChanges() {
    GetIt.I<ClothItemUiNotifier>().addListener(() {
      _dependancy.clothItems = GetIt.I<ClothItemQuerier>().getAll();
    });
  }
}

class ThemeStorageControllerInitialiser
    extends GetItRegisterableDependancy<ThemeSettingsController> {
  @override
  Future<void> _initialise() async {
    final storageAgent = SharedPreferencesThemeStorageAgent();
    _dependancy = ThemeSettingsController(storageAgent: storageAgent);
  }
}

class ClothItemExporterInitialiser
    extends GetItRegisterableDependancy<ClothItemExporter> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemJsonExporter();
  }
}

class ClothItemImporterInitialiser
    extends GetItRegisterableDependancy<ClothItemImporter> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemJsonImporter();
  }
}

class ClothItemMatcherInitialiser
    extends GetItRegisterableDependancy<ClothItemMatcher> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemMatcherImpl();
  }
}

class ClothItemFavouriteTogglerInitialiser
    extends GetItRegisterableDependancy<ClothItemFavouriteToggler> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemFavouriteTogglerImpl();
  }
}

class ClothItemDeleterInitialiser
    extends GetItRegisterableDependancy<ClothItemDeleter> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemDeleterImpl();
  }
}

class ClothItemSaverInitialiser
    extends GetItRegisterableDependancy<ClothItemSaver> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemSaverImpl();
  }
}

class ClothItemQuerierInitialiser
    extends GetItRegisterableDependancy<ClothItemQuerier> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemQuerierImpl();
  }
}

class ClothItemUiNotifierInitialiser
    extends GetItRegisterableDependancy<ClothItemUiNotifier> {
  @override
  Future<void> _initialise() async {
    _dependancy = ClothItemUiNotifierImpl();
  }
}

class ClothItemDataGatewayInitialiser
    extends GetItRegisterableDependancy<ClothItemDataGateway> {
  @override
  Future<void> _initialise() async {
    final dataGateway = ClothItemHiveDataGateway();
    await dataGateway.initialise();
    _dependancy = dataGateway;
  }
}

abstract class GetItRegisterableDependancy<T extends Object>
    implements Dependancy {
  late final T _dependancy;

  @override
  Future<void> initialise() async {
    await _initialise();
    _registerWithGetit();
  }

  Future<void> _initialise();

  void _registerWithGetit() {
    GetIt.I.registerSingleton<T>(_dependancy);
  }
}

abstract class Dependancy {
  Future<void> initialise();
}
