import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';
import 'package:wardrobe_app/theme/utils.dart';

class ColorSchemeDropDownSettingsTile extends StatelessWidget {
  const ColorSchemeDropDownSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: themeSettingsController,
      builder: (_, __) {
        return ListTile(
          title: const Text("color scheme"),
          trailing: DropdownButton(
            value: themeSettingsController.colorSchemeSeed.value,
            onChanged: (value) => _setColorSchemeSeed(value!),
            items: _menuItems,
          ),
        );
      },
    );
  }

  List<DropdownMenuItem<int>> get _menuItems => [
        for (final entry in colorSchemeSeedOptions.entries)
          DropdownMenuItem(
            value: entry.value.value,
            child: Text(entry.key),
          )
      ];

  void _setColorSchemeSeed(int colorValue) {
    themeSettingsController.colorSchemeSeed = Color(colorValue);
  }

  ThemeSettingsController get themeSettingsController =>
      GetIt.I.get<ThemeSettingsController>();
}
