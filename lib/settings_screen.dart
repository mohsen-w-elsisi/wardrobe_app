import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wardrobe_app/theme/theme_provider.dart';
import 'package:wardrobe_app/theme/utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar.medium(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("settings"),
            ),
          ),
          SliverList.list(
            children: const [
              ColorSchemeDropDownSettingsTile(),
            ],
          )
        ],
      ),
    );
  }
}

class ColorSchemeDropDownSettingsTile extends StatelessWidget {
  const ColorSchemeDropDownSettingsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("color scheme"),
      trailing: DropdownButton(
        value: context.watch<ThemeProvider>().colorSchemeSeed,
        onChanged: (value) => _setColorSchemeSeed(context, value!),
        items: [
          for (final entry in colorSchemeSeedOptions.entries)
            DropdownMenuItem(
              value: entry.value,
              child: Text(entry.key),
            )
        ],
      ),
    );
  }

  void _setColorSchemeSeed(BuildContext context, Color color) {
    context.read<ThemeProvider>().colorSchemeSeed = color;
  }
}
