import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const Map<ClothItemType, String> clothTypeTextMap = {
  ClothItemType.top: "top",
  ClothItemType.bottom: "bottom",
  ClothItemType.jacket: "jacket",
};

const Map<ClothItemAttribute, IconData> clothAttributeIconMap = {
  ClothItemAttribute.classic: FontAwesomeIcons.c,
  ClothItemAttribute.onFasion: Icons.celebration_outlined,
  ClothItemAttribute.sportive: Icons.sports_basketball
};
