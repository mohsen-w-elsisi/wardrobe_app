import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item/cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';

class ClothItemMatchingDialog extends StatelessWidget {
  final clothItemManager = GetIt.I.get<ClothItemManager>();
  final NewClothItemManager newClothItemManager;
  final void Function(BuildContext) onDismiss;

  ClothItemMatchingDialog({
    required this.newClothItemManager,
    required this.onDismiss,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Stack(children: [
          Column(
            children: [
              _dialogTitle(context),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: _listBody(),
                ),
              ),
            ],
          ),
          _saveButton(context),
        ]),
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

  Widget _listBody() {
    return StatefulBuilder(
      builder: (context, setState) => ListView(
        children: [
          for (final clothItem in clothItemManager.clothItems)
            ListTile(
              dense: true,
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              selected: _itemIsSelected(clothItem),
              onTap: () => setState(() => _toggleSelectionStatus(clothItem)),
              leading: Checkbox(
                value: _itemIsSelected(clothItem),
                shape: const CircleBorder(),
                onChanged: (value) {},
              ),
              title: Text(clothItem.name),
            )
        ],
      ),
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
