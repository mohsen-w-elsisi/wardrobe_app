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

  Widget get _listOrEmptyMessage =>
      _outfits.isNotEmpty ? _list : _noOutfitsMessage;

  Widget get _noOutfitsMessage {
    return const SliverFillRemaining(
      child: Center(
        child: Text("no outfits saved yet"),
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
      listenable: GetIt.I<OutfitUiNotifier>(),
      builder: (_, __) {
        return SliverList.separated(
          itemCount: _outfits.length,
          itemBuilder: (_, index) => OutfitTile(_outfits[index]),
          separatorBuilder: (_, __) => const Divider(),
        );
      },
    );
  }

  List<Outfit> get _outfits => GetIt.I<OutfitQuerier>().getAll().toList();
}
