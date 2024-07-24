import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/theme/theme_settings_controller.dart';
import 'package:wardrobe_app/theme/utils.dart';

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
                    ColorSchemeDropDownSettingsTile(),
                    ColorSchemeClearWardrobeTile(),
                  ],
                )
              ],
            );
          }),
    );
  }
}

class ColorSchemeClearWardrobeTile extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();

  ColorSchemeClearWardrobeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "clear wardobe",
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      onTap: () => _askToDeleteAllWardrobe(context),
    );
  }

  void _askToDeleteAllWardrobe(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Are you sure you want to delete everything?"),
        content: const Text("deleted data cannot be recovered."),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text("cancel"),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              clothItemManager.deleteAllItems();
            },
            child: const Text("delete"),
          ),
        ],
      ),
    );
  }
}

class ColorSchemeDropDownSettingsTile extends StatelessWidget {
  final themeSettingsController = GetIt.I.get<ThemeSettingsController>();

  ColorSchemeDropDownSettingsTile({super.key});

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
