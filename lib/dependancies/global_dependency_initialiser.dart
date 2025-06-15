import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wardrobe_app/cloth_item/persistance/hive_data_gateway.dart';
import 'package:wardrobe_app/cloth_item/domain/data_gateway.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/deleter.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/exporter.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/favourite_toggler.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/importer.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/matcher.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/querier.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/saver.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/impls/ui_notifier.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/outfit/backend/hive_storage_agent.dart';
import 'package:wardrobe_app/outfit/backend/manager.dart';
import 'package:wardrobe_app/theme/shared_preferences_theme_storage_agent.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';

class GlobalDependencyInitialiser {
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
