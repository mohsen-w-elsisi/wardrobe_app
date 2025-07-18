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
      builder: (lightDynamic, darkDynamic) => MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightDynamic,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          useMaterial3: true,
          colorScheme: darkDynamic,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
