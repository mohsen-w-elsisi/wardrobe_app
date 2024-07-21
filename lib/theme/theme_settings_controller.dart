import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:wardrobe_app/theme/utils.dart';

class ThemeSettingsController {
  late final ColorSchemeSeedStorageAgent _storageAgent;
  late Color _colorSchemeSeed;

  late BehaviorSubject<Color> _behaviourSubject;

  ThemeSettingsController({
    required ColorSchemeSeedStorageAgent storageAgent,
    Color defaultColor = Colors.amber,
  }) {
    _storageAgent = storageAgent;
    _colorSchemeSeed = defaultColor;
    _behaviourSubject = BehaviorSubject.seeded(_colorSchemeSeed);

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
    _behaviourSubject.add(_colorSchemeSeed);
    _storageAgent.saveColorSchemeSeed(_colorSchemeSeed);
  }

  Color get colorSchemeSeed => _colorSchemeSeed;

  set colorSchemeSeed(Color newSeed) => _setColorSchemeSeed(newSeed);

  Stream<Color> get stream => _behaviourSubject.stream;
}
