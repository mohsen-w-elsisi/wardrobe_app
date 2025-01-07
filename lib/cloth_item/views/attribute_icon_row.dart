import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/data_structures/data_structures.dart';

import '../dispay_options/attribute.dart';

class ClothItemAttributeIconRow extends StatelessWidget {
  final Iterable<ClothItemAttribute> attributes;
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
              clothItemAttributeDisplayOptions[attribute]!.icon,
              size: 20,
            ),
          )
      ],
    );
  }
}
