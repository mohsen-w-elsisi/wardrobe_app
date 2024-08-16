import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:wardrobe_app/cloth_item_editers/new_cloth_item_manager.dart';
import 'package:wardrobe_app/cloth_item_views/dispay_options/type.dart';

class NewClothItemScreenTypeSelector extends StatelessWidget {
  final NewClothItemManager newClothItemManager;

  const NewClothItemScreenTypeSelector({
    required this.newClothItemManager,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "type: ",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StatefulBuilder(
            builder: (context, setState) => DropdownButton(
              value: newClothItemManager.type,
              onChanged: (value) => setState(
                () => newClothItemManager.type = value!,
              ),
              items: [
                for (final type in ClothItemType.values)
                  DropdownMenuItem(
                    value: type,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          clothItemTypeDisplayOptions[type]!.icon,
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(clothItemTypeDisplayOptions[type]!.text),
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
