import 'package:flutter/material.dart';
import 'utils.dart';

class ThemeProvider extends ChangeNotifier {
  late final ColorSchemeSeedStorageAgent _databaseInterface;
  Color _colorSchemeSeed = Colors.amber;

  ThemeProvider({required ColorSchemeSeedStorageAgent databaseAgent}) {
    _databaseInterface = databaseAgent;
    _databaseInterface.getColorSchemeSeed().then(
      (savedColorSchemeSeed) {
        if (savedColorSchemeSeed != null) {
          _colorSchemeSeed = savedColorSchemeSeed;
        }
      },
    );
  }

  void _updateDatabaseImage() =>
      _databaseInterface.saveColorSchemeSeed(_colorSchemeSeed);

  Color get colorSchemeSeed => _colorSchemeSeed;

  set colorSchemeSeed(Color colorSchemeSeed) {
    _colorSchemeSeed = colorSchemeSeed;
    notifyListeners();
    _updateDatabaseImage();
  }
}
