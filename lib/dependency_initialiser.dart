import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'cloth_item/backend/hive_storage_agent.dart';
import "cloth_item/backend/import_export.dart";
import 'cloth_item/backend/manager.dart';
import 'outfit/backend/manager.dart';
import 'theme/shared_preferences_theme_storage_agent.dart';
import 'theme/theme_settings_controller.dart';
import 'outfit/backend/hive_storage_agent.dart';

class AppDependencyInitialiser {
  static Future<void> initiaseDependencies() async {
    await _initHive();
    await _initClothItemManager();
    await _initOutfitManager();
    _initThemeSettingsController();
  }

  static Future<void> _initHive() async {
    await Hive.initFlutter();
  }

  static Future<void> _initClothItemManager() async {
    final storageAgent = await _createClothItemStorageAgent();
    final clothItemManager = ClothItemManager(
      storageAgent: storageAgent,
      importer: MockClothItemImporter(),
      exporter: MockClothItemExporter(),
    );
    _registerWithGetIt(clothItemManager);
  }

  static Future<ClothItemStorageAgent> _createClothItemStorageAgent() async {
    final storageAgent = HiveClothItemStorageAgent();
    await storageAgent.initialize();
    return storageAgent;
  }

  static Future<void> _initOutfitManager() async {
    final storageAgent = await _createOutfitStorageAgent();
    final outfitManager = OutfitManager(storageAgent: storageAgent);
    _registerWithGetIt(outfitManager);
  }

  static Future<OutfitStorageAgent> _createOutfitStorageAgent() async {
    final storageAgent = HiveOutfitStorageAgent();
    await storageAgent.initialise();
    return storageAgent;
  }

  static void _initThemeSettingsController() {
    final storageAgent = SharedPreferencesThemeStorageAgent();
    final themeSettingsController = ThemeSettingsController(
      storageAgent: storageAgent,
    );
    _registerWithGetIt(themeSettingsController);
  }

  static void _registerWithGetIt<T extends Object>(T object) {
    GetIt.I.registerSingleton<T>(object);
  }
}
