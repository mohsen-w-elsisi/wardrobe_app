import 'package:flutter/material.dart';
import 'package:wardrobe_app/cloth_item/domain/ui_controllers.dart';

class ClothItemUiNotifierImpl extends ClothItemUiNotifier with ChangeNotifier {
  @override
  void notifyUi() => notifyListeners();
}
