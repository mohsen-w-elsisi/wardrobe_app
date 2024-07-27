import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/cloth_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClothItemAttributeIconRow extends StatelessWidget {
  final List<ClothItemAttribute> attributes;
  final bool alignEnd;

  const ClothItemAttributeIconRow(
    this.attributes, {
    super.key,
    this.alignEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          alignEnd ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        for (final attribute in attributes)
          Padding(
            padding: alignEnd
                ? const EdgeInsets.only(left: 4)
                : const EdgeInsets.only(right: 4),
            child: Icon(
              clothAttributeIconMap[attribute],
              size: 20,
            ),
          )
      ],
    );
  }
}

const Map<ClothItemSortMode, String> sortModeLabelMap = {
  ClothItemSortMode.byDateCreated: "date created",
  ClothItemSortMode.byName: "name",
};

enum ClothItemSortMode { byName, byDateCreated }

const Map<ClothItemAttribute, IconData> clothAttributeIconMap = {
  ClothItemAttribute.classic: FontAwesomeIcons.c,
  ClothItemAttribute.onFasion: Icons.celebration_outlined,
  ClothItemAttribute.sportive: Icons.sports_basketball
};

const Map<ClothItemType, String> clothTypeTextMap = {
  ClothItemType.top: "top",
  ClothItemType.bottom: "bottom",
  ClothItemType.jacket: "jacket",
};
