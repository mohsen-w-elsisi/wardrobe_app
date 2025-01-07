import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/use_cases/use_cases.dart';

class ClothItemUiNotifierImpl extends ClothItemUiNotifier with ChangeNotifier {
  @override
  void notifyUi() => notifyListeners();
}
