import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/entities/data_structures.dart';

enum ClothItemTypeDisplayConfig {
  headWear(ClothItemType.headWear, "head wear", "hat.svg"),
  top(ClothItemType.top, "top", "top.svg"),
  bottom(ClothItemType.bottom, "leg ware", "pants.svg"),
  jacket(ClothItemType.jacket, "jacket", "jacket.svg"),
  shoe(ClothItemType.shoe, "shoe", "shoe.svg");

  static const _typeIconsPathPrefix = "assets/type_icons";
  static const _typeIconsPathPrefixLight = "$_typeIconsPathPrefix/light_mode";
  static const _typeIconsPathPrefixDark = "$_typeIconsPathPrefix/dark_mode";

  const ClothItemTypeDisplayConfig(this.type, this.text, String iconPath)
      : _iconLightPath = "$_typeIconsPathPrefixLight/$iconPath",
        _iconDarkPath = "$_typeIconsPathPrefixDark/$iconPath";

  final ClothItemType type;
  final String text;
  final String _iconLightPath;
  final String _iconDarkPath;

  factory ClothItemTypeDisplayConfig.of(ClothItemType type) {
    return ClothItemTypeDisplayConfig.values.firstWhere(
      (config) => config.type == type,
    );
  }

  String iconPath(BuildContext context) {
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    return isLightMode ? _iconLightPath : _iconDarkPath;
  }
}
