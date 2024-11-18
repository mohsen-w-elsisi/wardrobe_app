import 'package:flutter/material.dart';

import 'about_app_tile.dart';
import 'clear_wardrobe_tile.dart';
import 'color_scheme.dart';
import 'import_export_tile.dart';

class SettingsScreen extends StatelessWidget {
  static const _settingsTiles = [
    ColorSchemeDropDownSettingsTile(),
    SettingsScreenImportTile(),
    SettingsScreenExportTile(),
    SettingsScreenClearWardrobeTile(),
    AboutAppTile(),
  ];

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _AppBar(),
          SliverList.list(children: _settingsTiles),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar.medium(
      flexibleSpace: FlexibleSpaceBar(
        title: Text("settings"),
      ),
    );
  }
}
