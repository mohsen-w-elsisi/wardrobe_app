import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_organiser.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';

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
    showModalBottomSheet(context: context, builder: (context) => this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Stack(
        children: [
          Column(
            children: [
              _dialogTitle(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _ListBody(
                    newClothItemManager: newClothItemManager,
                    clothItem: clothItem,
                  ),
                ),
              ),
            ],
          ),
          _saveButton(context),
        ],
      ),
    );
  }

  Widget _dialogTitle(BuildContext context) {
    return Text(
      "Select matching items",
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _saveButton(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: () {
            Navigator.pop(context);
            onDismiss(context);
          },
          child: const Text("save"),
        ),
      ),
    );
  }
}

class _ListBody extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final NewClothItemManager newClothItemManager;
  final ClothItem clothItem;
  late final ClothItemOrganiser clothItemOrganiser;

  _ListBody({
    super.key,
    required this.newClothItemManager,
    required this.clothItem,
  }) {
    clothItemOrganiser = ClothItemOrganiser(clothItemManager.clothItems);
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (context, setState) {
        return ListView(
          children: [
            for (final type in ClothItemType.values)
              if (type != clothItem.type)
                for (final item in clothItemOrganiser.filterBytype(type))
                  _listTile(item, setState)
          ],
        );
      },
    );
  }

  ListTile _listTile(ClothItem item, StateSetter setState) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      selected: _itemIsSelected(item),
      onTap: () => setState(() => _toggleSelectionStatus(item)),
      leading: Checkbox(
        value: _itemIsSelected(item),
        shape: const CircleBorder(),
        onChanged: (value) {},
      ),
      title: Text(item.name),
      trailing: null, //TODO: add icon here
    );
  }

  void _toggleSelectionStatus(ClothItem clothItem) {
    if (_itemIsSelected(clothItem)) {
      newClothItemManager.matchingItems.removeWhere(
        (testId) => testId == clothItem.id,
      );
    } else {
      newClothItemManager.matchingItems.add(clothItem.id);
    }
  }

  bool _itemIsSelected(ClothItem clothItem) =>
      newClothItemManager.matchingItems.contains(clothItem.id);
}
