import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wardrobe_app/cloth_item_views/grid_view.dart';
import 'package:wardrobe_app/outfit/manager.dart';
import 'package:wardrobe_app/outfit/outfit.dart';

class OutfitPresenterScreen extends StatelessWidget {
  final Outfit outfit;

  const OutfitPresenterScreen(this.outfit, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          _AppBar(outfit: outfit),
          ClothItemGridView(outfit.items, sliver: true),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  final Outfit outfit;

  const _AppBar({required this.outfit});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      actions: _actions,
      title: Text(outfit.isEphemiral ? "new outfit" : outfit.name),
    );
  }

  List<Widget> get _actions {
    return [
      _shareButton,
      _saveButton,
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
    final files = [for (final item in outfit.items) XFile.fromData(item.image)];
    Share.shareXFiles(files, text: "what do you think of this outfit");
  }

  IconButton get _saveButton {
    return IconButton(
      tooltip: "save",
      onPressed: _save,
      icon: const Icon(Icons.save_alt),
    );
  }

  void _save() {
    final outfitManager = GetIt.I.get<OutfitManager>();
    final newOutfit = Outfit(
      items: outfit.items,
      name: "new oufit",
      id: DateTime.now().toIso8601String(),
    );
    outfitManager.saveOutfit(newOutfit);
  }
}
