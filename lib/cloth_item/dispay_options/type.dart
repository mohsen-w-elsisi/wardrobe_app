import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';

class ClothItemTypeIconQuerier {
  final BuildContext _context;
  final ClothItemType _type;

  ClothItemTypeIconQuerier(this._context, this._type);

  String get icon {
    if (_isLightMode) {
      return _typeDisplayOption.iconLight;
    } else {
      return _typeDisplayOption.iconDark;
    }
  }

  ClothItemTypeDisplayOption get _typeDisplayOption {
    return clothItemTypeDisplayOptions[_type]!;
  }

  bool get _isLightMode {
    final themeBrightness = Theme.of(_context).brightness;
    return themeBrightness == Brightness.light;
  }
}

const ClothItemTypeDisplayOptions clothItemTypeDisplayOptions = {
  ClothItemType.headWear: ClothItemTypeDisplayOption(
    text: "head wear",
    icon: "hat.svg",
  ),
  ClothItemType.top: ClothItemTypeDisplayOption(
    text: "top",
    icon: "top.svg",
  ),
  ClothItemType.bottom: ClothItemTypeDisplayOption(
    text: "leg ware",
    icon: "pants.svg",
  ),
  ClothItemType.jacket: ClothItemTypeDisplayOption(
    text: "jacket",
    icon: "jacket.svg",
  ),
  ClothItemType.shoe: ClothItemTypeDisplayOption(
    text: "shoe",
    icon: "shoe.svg",
  ),
};

typedef ClothItemTypeDisplayOptions
    = Map<ClothItemType, ClothItemTypeDisplayOption>;

class ClothItemTypeDisplayOption<T extends ClothItemType> {
  static const _typeIconsPathPrefix = "assets/type_icons";
  static const _typeIconsPathPrefixLight = "$_typeIconsPathPrefix/light_mode";
  static const _typeIconsPathPrefixDark = "$_typeIconsPathPrefix/dark_mode";

  final String text;
  final String iconLight;
  final String iconDark;

  const ClothItemTypeDisplayOption({
    required this.text,
    required String icon,
  })  : iconLight = "$_typeIconsPathPrefixLight/$icon",
        iconDark = "$_typeIconsPathPrefixDark/$icon";
}
