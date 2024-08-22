import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/dependency_initialiser.dart';
import 'package:wardrobe_app/home_screen.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';

Future<void> main() async {
  await AppDependencyInitialiser.initiaseDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeSettingsController,
      builder: (_, __) {
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: themeSettingsController.colorSchemeSeed,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            colorSchemeSeed: themeSettingsController.colorSchemeSeed,
          ),
          home: HomeScreen(),
        );
      },
    );
  }

  ThemeSettingsController get themeSettingsController =>
      GetIt.I.get<ThemeSettingsController>();
}
