import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/outfit/domain/ui_notifier.dart';
import 'package:wardrobe_app/outfit/domain/use_cases/use_cases.dart';

import '../../domain/outfit.dart';
import '../shared_widgets/tile.dart';

class OutfitListScreen extends StatelessWidget {
  const OutfitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar,
          _listOrEmptyMessage,
        ],
      ),
    );
  }

  Widget get _listOrEmptyMessage {
    return FutureBuilder(
      future: _outfits,
      builder: (_, snapshot) {
        if (snapshot.hasData) {
          final outfits = snapshot.data!;
          if (outfits.isNotEmpty) {
            return _list(outfits);
          } else {
            return _noOutfitsMessage;
          }
        } else {
          return _loadingSpinner;
        }
      },
    );
  }

  Widget get _noOutfitsMessage {
    return const SliverFillRemaining(
      child: Center(
        child: Text("no outfits saved yet"),
      ),
    );
  }

  Widget get _loadingSpinner {
    return const SliverFillRemaining(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  SliverAppBar get _appBar {
    return const SliverAppBar.medium(
      title: Text("saved outfits"),
    );
  }

  Widget _list(List<Outfit> outfits) {
    return ListenableBuilder(
      listenable: GetIt.I<OutfitUiNotifier>(),
      builder: (_, __) {
        return SliverList.separated(
          itemCount: outfits.length,
          itemBuilder: (_, index) => OutfitTile(outfits[index]),
          separatorBuilder: (_, __) => const Divider(),
        );
      },
    );
  }

  Future<List<Outfit>> get _outfits async =>
      (await GetIt.I<OutfitQuerier>().getAllOfCurrentSeason()).toList();
}
