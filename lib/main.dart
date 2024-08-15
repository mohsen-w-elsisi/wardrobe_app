import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/manager.dart';
import 'package:wardrobe_app/cloth_item/hive_storage_agent.dart';
import 'package:wardrobe_app/home_screen.dart';
import 'package:wardrobe_app/outfit/hive_storage_agent.dart';
import 'package:wardrobe_app/outfit/manager.dart';
import 'package:wardrobe_app/theme/shared_preferences_theme_storage_agent.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();

  await _initClothItemManager();
  await _initOutfitManager();
  _initThemeSettingsController();

  runApp(const App());
}

Future<void> _initClothItemManager() async {
  final hiveClothItemStorageAgent = HiveClothItemStorageAgent();
  await hiveClothItemStorageAgent.initialize();

  GetIt.I.registerSingleton<ClothItemManager>(
    ClothItemManager(
      storageAgent: hiveClothItemStorageAgent,
    ),
  );
}

Future<void> _initOutfitManager() async {
  final storageAgent = HiveOutfitStorageAgent();
  await storageAgent.initialise();

  GetIt.I.registerSingleton<OutfitManager>(
    OutfitManager(
      storageAgent: storageAgent,
    ),
  );
}

void _initThemeSettingsController() {
  GetIt.I.registerSingleton<ThemeSettingsController>(
    ThemeSettingsController(
      storageAgent: SharedPreferencesThemeStorageAgent(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeSettingsController = GetIt.I.get<ThemeSettingsController>();

    return ListenableBuilder(
      listenable: themeSettingsController,
      builder: (context, _) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: themeSettingsController.colorSchemeSeed,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: themeSettingsController.colorSchemeSeed,
          ),
          home: HomeScreen(),
        );
      },
    );
  }
}
