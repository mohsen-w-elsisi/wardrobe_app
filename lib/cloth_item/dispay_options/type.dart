import 'package:wardrobe_app/cloth_item/backend/cloth_item.dart';

const ClothItemTypeDisplayOptions clothItemTypeDisplayOptions = {
  ClothItemType.headWear: ClothItemTypeDisplayOption(
    text: "head wear",
    icon: "$_typeIconsPathPrefix/hat.svg",
  ),
  ClothItemType.top: ClothItemTypeDisplayOption(
    text: "top",
    icon: "$_typeIconsPathPrefix/top.svg",
  ),
  ClothItemType.bottom: ClothItemTypeDisplayOption(
    text: "leg ware",
    icon: "$_typeIconsPathPrefix/pants.svg",
  ),
  ClothItemType.jacket: ClothItemTypeDisplayOption(
    text: "jacket",
    icon: "$_typeIconsPathPrefix/jacket.svg",
  ),
  ClothItemType.shoe: ClothItemTypeDisplayOption(
    text: "shoe",
    icon: "$_typeIconsPathPrefix/shoe.svg",
  ),
};

typedef ClothItemTypeDisplayOptions
    = Map<ClothItemType, ClothItemTypeDisplayOption>;

class ClothItemTypeDisplayOption<T extends ClothItemType> {
  final String text;
  final String icon;

  const ClothItemTypeDisplayOption({
    required this.text,
    required this.icon,
  });
}

const _typeIconsPathPrefix = "assets/type_icons";
