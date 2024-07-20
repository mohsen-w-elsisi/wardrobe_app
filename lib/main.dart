import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe_app/home_screen.dart';
import 'package:wardrobe_app/theme/theme_provider.dart';
import 'package:wardrobe_app/theme/utils.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(
            databaseAgent: MockColorSchemeSeedStorageAgent(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) => MaterialApp(
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: context.watch<ThemeProvider>().colorSchemeSeed,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: context.watch<ThemeProvider>().colorSchemeSeed,
            brightness: Brightness.dark,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

class MockColorSchemeSeedStorageAgent extends ColorSchemeSeedStorageAgent {
  @override
  Future<Color> getColorSchemeSeed() => Future.delayed(
        Duration.zero,
        () => Colors.amber,
      );

  @override
  void saveColorSchemeSeed(Color colorSchemeSeed) {}
}
