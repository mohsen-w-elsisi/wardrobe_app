import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item/hive_cloth_item_storage_agent.dart';
import 'package:wardrobe_app/home_screen.dart';
import 'package:wardrobe_app/theme/shared_preferences_theme_storage_agent.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();

  await _initClothItemManager();

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

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    _registerThemeSettingsController();

    final themeSettingsController = GetIt.I.get<ThemeSettingsController>();

    return StreamBuilder<Color>(
      stream: themeSettingsController.stream,
      builder: (context, snapshot) {
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

  void _registerThemeSettingsController() {
    if (!GetIt.I.isRegistered<ThemeSettingsController>()) {
      GetIt.I.registerSingleton<ThemeSettingsController>(
        ThemeSettingsController(
          storageAgent: SharedPreferencesThemeStorageAgent(),
        ),
      );
    }
  }
}
