import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/shared/entities/season.dart';
import 'package:wardrobe_app/shared/use_cases/use_cases.dart';
import 'package:wardrobe_app/shared/widgets/season_dropdown_button.dart';

import 'about_app_tile.dart';
import 'clear_wardrobe_tile.dart';
import 'color_scheme.dart';
import 'import_export_tile.dart';

class SettingsScreen extends StatelessWidget {
  static const _settingsTiles = [
    SettingsScreenSeasonSelectorTile(),
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

class SettingsScreenSeasonSelectorTile extends StatelessWidget {
  const SettingsScreenSeasonSelectorTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("show cloths of"),
      trailing: FutureBuilder(
        future: _currentSeason(),
        builder: (_, snapshot) => snapshot.hasData
            ? _dropDownButton(snapshot.data!)
            : const CircularProgressIndicator(),
      ),
    );
  }

  Future<Season> _currentSeason() => GetIt.I<SeasonGetter>().currentSeason();

  Widget _dropDownButton(Season season) {
    return SeasonDropdownButton(
      initalSeason: season,
      onSeasonSelected: GetIt.I<SeasonSetter>().setSeason,
    );
  }
}
