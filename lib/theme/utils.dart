import 'package:flutter/material.dart';

abstract class ColorSchemeSeedStorageAgent {
  Future<Color?> getColorSchemeSeed();
  void saveColorSchemeSeed(Color colorSchemeSeed);
}

const Map<String, Color> colorSchemeSeedOptions = {
  "amber": Colors.amber,
  "pink": Colors.pink,
};
