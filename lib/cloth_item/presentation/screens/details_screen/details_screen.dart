import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/seasons.dart';
import 'package:wardrobe_app/outfit/views/maker_screen/maker_screen.dart';
import 'package:wardrobe_app/shared/entities/season.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/attributes.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/image.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_widgets/list_view.dart';

import 'app_bar.dart';

class ClothItemDetailScreen extends StatelessWidget {
  final String itemId;
  final bool enableHeroImage;

  late bool _itemexists;
  late ClothItem _clothItem;

  ClothItemDetailScreen(
    this.itemId, {
    this.enableHeroImage = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: GetIt.I<ClothItemUiNotifier>(),
      builder: (_, __) => FutureBuilder(
        future: _fetchClothitem(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container();
          } else {
            if (_itemexists) {
              return _filledDetailsView(_clothItem);
            } else {
              return Container();
            }
          }
        },
      ),
    );
  }

  Widget _filledDetailsView(ClothItem item) {
    return Scaffold(
      body: CustomScrollView(
        slivers: _componentSlivers(item),
      ),
      floatingActionButton: _StartOutfitFAB(clothItem: item),
    );
  }

  List<Widget> _componentSlivers(ClothItem item) {
    return [
      ClothItemDetailScreenAppBar(clothItem: item),
      _Image(clothItem: item, enableHeroImage: enableHeroImage),
      _DescribterChips(clothItem: item),
      _MatchingItemList(clothItem: item),
    ];
  }

  Future<void> _fetchClothitem() async {
    try {
      _clothItem = await GetIt.I<ClothItemQuerier>().getById(itemId);
      _itemexists = true;
    } on StateError {
      _itemexists = false;
    }
  }
}

class _Image extends StatelessWidget {
  final ClothItem clothItem;
  final bool enableHeroImage;

  const _Image({
    required this.clothItem,
    required this.enableHeroImage,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: enableHeroImage ? _heroClothItemImage : _clothItemImage,
      ),
    );
  }

  Widget get _heroClothItemImage => Hero(
        tag: clothItem.id,
        child: _clothItemImage,
      );

  Widget get _clothItemImage => ClothItemImage(clothItem: clothItem);
}

class _MatchingItemList extends StatelessWidget {
  final ClothItem clothItem;

  const _MatchingItemList({
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _matchingItems,
      builder: (_, snapshot) {
        return ClothItemListView(
          snapshot.data ?? [],
          sliver: true,
        );
      },
    );
  }

  Future<List<ClothItem>> get _matchingItems =>
      GetIt.I<ClothItemMatcher>().findMatchingItemsOfSeason(clothItem);
}

class _DescribterChips extends StatelessWidget {
  final ClothItem clothItem;

  const _DescribterChips({
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          spacing: 8.0,
          children: _chips,
        ),
      ),
    );
  }

  List<Widget> get _chips {
    return [
      if (clothItem.season != Season.all) _seasonChip,
      ..._attributeChips,
    ];
  }

  Widget get _seasonChip {
    return Chip(
      label: Text(SeasonDisplayConfig.of(clothItem.season).name),
      avatar: Icon(SeasonDisplayConfig.of(clothItem.season).icon),
    );
  }

  List<Widget> get _attributeChips {
    return [
      for (final attribute in clothItem.attributes)
        Chip(
          label: Text(ClothItemAttributeDisplayConfig.of(attribute).name),
          avatar: Icon(ClothItemAttributeDisplayConfig.of(attribute).icon),
        )
    ];
  }
}

class _StartOutfitFAB extends StatelessWidget {
  final ClothItem clothItem;

  const _StartOutfitFAB({
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      tooltip: "new outfit with this",
      onPressed: () => _openDetailsScreen(context),
      child: const Icon(Icons.checkroom_outlined),
    );
  }

  void _openDetailsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => OutfitMakerScreen(
          preSelectedItems: [clothItem],
        ),
      ),
    );
  }
}
