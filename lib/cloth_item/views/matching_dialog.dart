import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/views/details_screen.dart';
import 'package:wardrobe_app/cloth_item/presenters/type_display_options.dart';
import 'package:wardrobe_app/subbmitable_bottom_sheet.dart';

class ClothItemMatchingDialog extends StatelessWidget {
  final NewClothItemManager newClothItemManager;
  final void Function(BuildContext) onDismiss;
  final ClothItem clothItem;

  const ClothItemMatchingDialog({
    required this.newClothItemManager,
    required this.onDismiss,
    required this.clothItem,
    super.key,
  });

  void show(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.7;
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: maxHeight),
      context: context,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubmitableBottomSheet(
      context: context,
      title: "Select matching items",
      submitButtonText: "save",
      onSubmit: () => onDismiss(context),
      builder: (_) => _ListBody(
        newClothItemManager: newClothItemManager,
        clothItem: clothItem,
      ),
    );
  }
}

class _ListBody extends StatelessWidget {
  final clothItemQuerier = GetIt.I<ClothItemQuerier>();
  final NewClothItemManager newClothItemManager;
  final ClothItem clothItem;
  late final ClothItemOrganiser clothItemOrganiser;

  _ListBody({
    required this.newClothItemManager,
    required this.clothItem,
  }) {
    clothItemOrganiser = ClothItemOrganiser(clothItemQuerier.getAll());
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return ListView(
          children: _itemTiles(setState),
        );
      },
    );
  }

  List<Widget> _itemTiles(StateSetter setState) {
    return [
      for (final type in ClothItemType.values)
        if (type != clothItem.type)
          for (final item in clothItemOrganiser.filterBytype(type))
            _ListTile(
              newClothItemManager: newClothItemManager,
              setState: setState,
              item: item,
            )
    ];
  }
}

class _ListTile extends StatelessWidget {
  final NewClothItemManager newClothItemManager;
  final ClothItem item;
  final StateSetter setState;

  const _ListTile({
    required this.item,
    required this.setState,
    required this.newClothItemManager,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      selected: _itemIsSelected,
      onTap: _toggleSelectionStatus,
      onLongPress: () => _openDetailsScreen(context),
      leading: _checkbox,
      title: Text(item.name),
      trailing: _itemTypeIcon(context),
    );
  }

  Widget get _checkbox {
    return Checkbox(
      value: _itemIsSelected,
      shape: const CircleBorder(),
      onChanged: (value) {},
    );
  }

  Widget _itemTypeIcon(BuildContext context) {
    return SvgPicture.asset(
      ClothItemTypeIconQuerier(context, item.type).icon,
      height: 20,
    );
  }

  void _toggleSelectionStatus() {
    setState(() {
      if (_itemIsSelected) {
        newClothItemManager.matchingItems.removeWhere(
          (testId) => testId == item.id,
        );
      } else {
        newClothItemManager.matchingItems.add(item.id);
      }
    });
  }

  bool get _itemIsSelected =>
      newClothItemManager.matchingItems.contains(item.id);

  void _openDetailsScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ClothItemDetailScreen(item.id),
      ),
    );
  }
}
