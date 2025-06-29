import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/organiser.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/new_item_manager.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';
import 'package:wardrobe_app/cloth_item/presentation/screens/details_screen.dart';
import 'package:wardrobe_app/cloth_item/presentation/shared_presenters/display_configs/types.dart';
import 'package:wardrobe_app/common_widgets/subbmitable_bottom_sheet.dart';

class ClothItemMatchingDialog extends StatelessWidget {
  final ClothItemEditingManager newClothItemManager;
  final void Function(BuildContext) onDismiss;
  final ClothItem clothItem;

  const ClothItemMatchingDialog({
    required this.newClothItemManager,
    required this.onDismiss,
    required this.clothItem,
    super.key,
  });

  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SubmitableBottomSheet(
      context: context,
      scrollable: true,
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
  late final ClothItemOrganiser clothItemOrganiser;
  final ClothItemEditingManager newClothItemManager;
  final ClothItem clothItem;

  _ListBody({
    required this.newClothItemManager,
    required this.clothItem,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initOrganiser(),
      builder: (_, snapshot) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: snapshot.connectionState == ConnectionState.done
                  ? _itemTiles(setState)
                  : [],
            );
          },
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

  Future<void> _initOrganiser() async {
    final allItems = await clothItemQuerier.getAll();
    clothItemOrganiser = ClothItemOrganiser(allItems);
  }
}

class _ListTile extends StatelessWidget {
  final ClothItemEditingManager newClothItemManager;
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
