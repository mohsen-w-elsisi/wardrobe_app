import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/home_screen.dart';
import 'package:wardrobe_app/theme/shared_preferences_theme_storage_agent.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';

void main() {
  runApp(const App());
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
          home: const HomeScreen(),
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
