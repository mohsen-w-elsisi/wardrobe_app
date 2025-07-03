import 'package:flutter/cupertino.dart';

class OutfitUiNotifier with ChangeNotifier {
  void notify() {
    notifyListeners();
  }
}
