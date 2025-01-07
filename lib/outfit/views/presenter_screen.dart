import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/views/grid_view.dart';

import 'package:wardrobe_app/outfit/backend/manager.dart';
import 'package:wardrobe_app/outfit/backend/outfit.dart';
import 'package:wardrobe_app/outfit/backend/outfit_saver.dart';
import 'package:wardrobe_app/outfit/backend/sharer.dart';
import 'package:wardrobe_app/outfit/views/outfit_was_saved_snackbar.dart';

import 'saving_modal.dart';

class OutfitPresenterScreen extends StatelessWidget {
  final Outfit outfit;

  const OutfitPresenterScreen(this.outfit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _AppBar(outfit: outfit),
          if (_itemsWereDeleted)
            const SliverToBoxAdapter(
              child: _MissingClothItemsMessage(),
            ),
          ClothItemGridView(_clothItems, sliver: true),
        ],
      ),
    );
  }

  bool get _itemsWereDeleted => _clothItems.length != outfit.items.length;

  List<ClothItem> get _clothItems {
    final clothItemQuerier = GetIt.I<ClothItemQuerier>();
    return outfit.items.map(clothItemQuerier.getById).nonNulls.toList();
  }
}

class _MissingClothItemsMessage extends StatelessWidget {
  static const _borderRadius = BorderRadius.all(Radius.circular(12));
  static const _margin = EdgeInsets.symmetric(horizontal: 4, vertical: 4);
  static const _padding = EdgeInsets.all(18);
  static const _messageText =
      "one or more items included in the outfit have been deleted since the outfit was saved!";

  const _MissingClothItemsMessage();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        borderRadius: _borderRadius,
      ),
      margin: _margin,
      padding: _padding,
      child: Text(_messageText, style: _textStyle(context)),
    );
  }

  TextStyle _textStyle(BuildContext context) {
    final color = Theme.of(context).colorScheme.onErrorContainer;
    final baseStyle = Theme.of(context).textTheme.bodyMedium!;
    return baseStyle.copyWith(
      color: color,
    );
  }
}

class _AppBar extends StatelessWidget {
  final Outfit _outfit;

  const _AppBar({required Outfit outfit}) : _outfit = outfit;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      actions: _actions(context),
      title: Text(_outfit.isEphemiral ? "new outfit" : _outfit.name),
    );
  }

  List<Widget> _actions(BuildContext context) {
    return [
      _shareButton,
      _SaveButton(outfit: _outfit),
    ];
  }

  IconButton get _shareButton {
    return IconButton(
      tooltip: "share",
      onPressed: _share,
      icon: const Icon(Icons.share),
    );
  }

  void _share() {
    OutfitSharer(_clothItems).share();
  }

  List<ClothItem> get _clothItems {
    final clothitemQuerier = GetIt.I<ClothItemQuerier>();
    return _outfit.items.map(clothitemQuerier.getById).nonNulls.toList();
  }
}

class _SaveButton extends StatelessWidget {
  final _outfitManager = GetIt.I.get<OutfitManager>();
  final Outfit _outfit;

  _SaveButton({required Outfit outfit}) : _outfit = outfit;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _outfitManager,
      builder: (context, _) {
        return _outfitManager.outfitIsSaved(_outfit)
            ? _unsaveButton()
            : _saveButton(context);
      },
    );
  }

  Widget _saveButton(BuildContext context) {
    return IconButton(
      tooltip: "save",
      onPressed: () => _showSavingModal(context),
      icon: const Icon(Icons.bookmark_add_outlined),
    );
  }

  void _showSavingModal(BuildContext context) {
    final outfitSaver = OutfitSaver(outfit: _outfit);
    OutfitSavingDialog(
      outfitSaver: outfitSaver,
      onSubmit: () {
        OutfitWasSavedSnackbar(outfit: outfitSaver.outfit).show(context);
      },
    ).show(context);
  }

  Widget _unsaveButton() {
    return IconButton(
      tooltip: "remove from saved",
      onPressed: _unsave,
      icon: const Icon(Icons.bookmark_added_outlined),
    );
  }

  void _unsave() {
    final outfitManager = GetIt.I.get<OutfitManager>();
    outfitManager.deleteOutfit(_outfit);
  }
}
