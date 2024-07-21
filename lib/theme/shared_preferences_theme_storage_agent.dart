import 'package:flutter/material.dart';
import 'package:wardrobe_app/theme/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesThemeStorageAgent extends ColorSchemeSeedStorageAgent {
  static const sharedPreferencesKey = "color scheme seed";

  SharedPreferences? _sharedPreferences;
  late Future<SharedPreferences> _sharedPreferencesFuture;

  SharedPreferencesThemeStorageAgent() {
    _sharedPreferencesFuture = SharedPreferences.getInstance();
    _sharedPreferencesFuture.then(
      (sharedPreferences) => _sharedPreferences = sharedPreferences,
    );
  }

  Future<void> _waitForSharedPreferencesInstance() async {
    if (_sharedPreferences == null) {
      await _sharedPreferencesFuture;
    }
  }

  @override
  Future<Color?> getColorSchemeSeed() async {
    await _waitForSharedPreferencesInstance();
    final colorValue = _sharedPreferences!.getInt(sharedPreferencesKey);
    return colorValue != null ? Color(colorValue) : null;
  }

  @override
  Future<void> saveColorSchemeSeed(Color colorSchemeSeed) async {
    await _waitForSharedPreferencesInstance();
    _sharedPreferences!.setInt(sharedPreferencesKey, colorSchemeSeed.value);
  }
}
