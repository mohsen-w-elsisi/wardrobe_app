import 'package:flutter/material.dart';
import 'package:wardrobe_app/theme/utils.dart';

class ThemeSettingsController extends ChangeNotifier {
  late final ColorSchemeSeedStorageAgent _storageAgent;
  late Color _colorSchemeSeed;

  ThemeSettingsController({
    required ColorSchemeSeedStorageAgent storageAgent,
    Color defaultColor = Colors.amber,
  }) {
    _storageAgent = storageAgent;
    _colorSchemeSeed = defaultColor;

    _storageAgent.getColorSchemeSeed().then(
      (value) {
        if (value != null) {
          _setColorSchemeSeed(value);
        }
      },
    );
  }

  void _setColorSchemeSeed(Color newSeed) {
    _colorSchemeSeed = newSeed;
    _storageAgent.saveColorSchemeSeed(_colorSchemeSeed);
    notifyListeners();
  }

  Color get colorSchemeSeed => _colorSchemeSeed;

  set colorSchemeSeed(Color newSeed) => _setColorSchemeSeed(newSeed);
}
