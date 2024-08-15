import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'outfit.dart';
import 'tile.dart';
import 'manager.dart';

class OutfitListScreen extends StatelessWidget {
  const OutfitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar,
          _list,
        ],
      ),
    );
  }

  SliverAppBar get _appBar {
    return const SliverAppBar.medium(
      title: Text("saved outfits"),
    );
  }

  SliverList get _list {
    return SliverList.separated(
      itemCount: _outfits.length,
      itemBuilder: (_, index) => OutfitTile(_outfits[index]),
      separatorBuilder: (_, __) => const Divider(),
    );
  }

  List<Outfit> get _outfits {
    final outfitManager = GetIt.I.get<OutfitManager>();
    return outfitManager.outfits;
  }
}
