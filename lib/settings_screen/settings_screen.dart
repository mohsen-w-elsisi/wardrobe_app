import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';
import 'package:wardrobe_app/theme/utils.dart';

import 'settings_screen_clear_wardrobe_tile.dart';

class SettingsScreen extends StatelessWidget {
  final themeSettingsController = GetIt.I.get<ThemeSettingsController>();

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
          listenable: themeSettingsController,
          builder: (context, _) {
            return CustomScrollView(
              slivers: <Widget>[
                const SliverAppBar.medium(
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text("settings"),
                  ),
                ),
                SliverList.list(
                  children: [
                    _ColorSchemeDropDownSettingsTile(),
                    const SettingsScreenClearWardrobeTile(),
                  ],
                )
              ],
            );
          }),
    );
  }
}

class _ColorSchemeDropDownSettingsTile extends StatelessWidget {
  final themeSettingsController = GetIt.I.get<ThemeSettingsController>();

  _ColorSchemeDropDownSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      for (final entry in colorSchemeSeedOptions.entries)
        DropdownMenuItem(
          value: entry.value.value,
          child: Text(entry.key),
        )
    ];
    return ListTile(
      title: const Text("color scheme"),
      trailing: DropdownButton(
        value: themeSettingsController.colorSchemeSeed.value,
        onChanged: (value) => _setColorSchemeSeed(value!),
        items: items,
      ),
    );
  }

  void _setColorSchemeSeed(int colorValue) {
    themeSettingsController.colorSchemeSeed = Color(colorValue);
  }
}
