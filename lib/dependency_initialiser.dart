import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wardrobe_app/cloth_item/backend/differ.dart';
import 'package:wardrobe_app/cloth_item/backend/hive_storage_agent.dart';
import 'package:wardrobe_app/cloth_item/backend/image_manager.dart';
import 'package:wardrobe_app/cloth_item/backend/import_export.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';
import 'package:wardrobe_app/cloth_item/backend/querier.dart';
import 'package:wardrobe_app/cloth_item/views/compound_view/settings.dart';
import 'package:wardrobe_app/outfit/backend/hive_storage_agent.dart';
import 'package:wardrobe_app/outfit/backend/manager.dart';
import 'package:wardrobe_app/theme/shared_preferences_theme_storage_agent.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';

class AppDependencyInitialiser {
  static final List<Dependancy> _dependancies = [
    HiveInitialiser(),
    ClothItemManagerInitialiser(),
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

class ClothItemManagerInitialiser
    extends GetItRegisterableDependancy<ClothItemManager> {
  @override
  Future<void> _initialise() async {
    final storageAgent = await _createStorageAgent();

    final querier = ClothItemQuerierImpl(items: storageAgent.savedItems);

    _dependancy = ClothItemManager(
      querier: querier,
      storageAgent: storageAgent,
      createDiffer: CLothItemDifferImpl.new,
      importExportClient: ClothItemJsonImportExportClient(),
      imageManager: ClothItemImageManagerImpl(),
    );
  }

  Future<ClothItemStorageAgent> _createStorageAgent() async {
    final storageAgent = HiveClothItemStorageAgent();
    await storageAgent.initialize();
    return storageAgent;
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
      clothItems: _clothItemManager.clothItems,
      settings: _defaultSettings,
    );
  }

  void _listenForItemChanges() {
    _clothItemManager.addListener(() {
      _dependancy.clothItems = _clothItemManager.clothItems;
    });
  }

  ClothItemManager get _clothItemManager => GetIt.I.get<ClothItemManager>();
}

class ThemeStorageControllerInitialiser
    extends GetItRegisterableDependancy<ThemeSettingsController> {
  @override
  Future<void> _initialise() async {
    final storageAgent = SharedPreferencesThemeStorageAgent();
    _dependancy = ThemeSettingsController(storageAgent: storageAgent);
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
