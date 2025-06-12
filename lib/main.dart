import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/dependancies/global_dependency_initialiser.dart';
import 'package:wardrobe_app/home_screen.dart';
import 'package:wardrobe_app/l10n/app_localizations.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';

Future<void> main() async {
  await GlobalDependencyInitialiser.initiaseDependencies();
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
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            AppLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: themeSettingsController.colorSchemeSeed,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            colorSchemeSeed: themeSettingsController.colorSchemeSeed,
          ),
          home: const HomeScreen(),
        );
      },
    );
  }

  ThemeSettingsController get themeSettingsController =>
      GetIt.I.get<ThemeSettingsController>();
}
