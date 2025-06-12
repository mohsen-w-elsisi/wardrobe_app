import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/l10n/app_localizations.dart';

import '../backend/outfit.dart';
import 'tile.dart';
import '../backend/manager.dart';

class OutfitListScreen extends StatelessWidget {
  const OutfitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar,
          _listOrEmptyMessage(context),
        ],
      ),
    );
  }

  Widget _listOrEmptyMessage(BuildContext context) =>
      _outfits.isNotEmpty ? _list : _noOutfitsMessage(context);

  Widget _noOutfitsMessage(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.noOutfitsSaved,
        ),
      ),
    );
  }

  SliverAppBar get _appBar {
    return const SliverAppBar.medium(
      title: Text("saved outfits"),
    );
  }

  Widget get _list {
    return ListenableBuilder(
      listenable: _outfitManager,
      builder: (_, __) {
        return SliverList.separated(
          itemCount: _outfits.length,
          itemBuilder: (_, index) => OutfitTile(_outfits[index]),
          separatorBuilder: (_, __) => const Divider(),
        );
      },
    );
  }

  List<Outfit> get _outfits => _outfitManager.outfits;

  OutfitManager get _outfitManager => GetIt.I.get<OutfitManager>();
}
