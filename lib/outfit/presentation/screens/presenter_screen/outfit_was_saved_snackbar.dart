import 'package:flutter/material.dart';
import 'package:wardrobe_app/outfit/domain/outfit.dart';
import 'package:wardrobe_app/outfit/presentation/screens/presenter_screen/presenter_screen.dart';

class OutfitWasSavedSnackbar {
  final Outfit outfit;

  const OutfitWasSavedSnackbar({
    required this.outfit,
  });

  void show(BuildContext context) {
    final snackBar = build(context);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  SnackBar build(BuildContext context) {
    return SnackBar(
      content: Row(
        children: [
          const Text("new outfit saved"),
          const Spacer(),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(_route);
            },
            child: const Text("view"),
          )
        ],
      ),
    );
  }

  Route get _route {
    return MaterialPageRoute(
      builder: (context) => OutfitPresenterScreen(
        outfit,
      ),
    );
  }
}
