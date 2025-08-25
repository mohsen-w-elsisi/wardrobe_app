import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:wardrobe_app/dependancies/global_dependency_initialiser.dart';
import 'package:wardrobe_app/home_screen.dart';

Future<void> main() async {
  await GlobalDependencyInitialiser.initiaseDependencies();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (dynamicColorScheme, _) {
        return MaterialApp(
          theme: _themeFromDynamicScheme(dynamicColorScheme),
          darkTheme: _themeFromDynamicScheme(dynamicColorScheme, dark: true),
          home: const HomeScreen(),
        );
      },
    );
  }

  ThemeData _themeFromDynamicScheme(
    ColorScheme? dynamicScheme, {
    bool dark = false,
  }) {
    final primaryColor = dynamicScheme?.primary ?? Colors.blue;
    final brightness = dark ? Brightness.dark : Brightness.light;
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: brightness,
      ),
    );
  }
}
