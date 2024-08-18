import 'package:flutter/material.dart';
import 'package:wardrobe_app/outfit/backend/outfit.dart';
import 'package:wardrobe_app/outfit/views/presenter_screen.dart';

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
              Navigator.of(context)
                  .pushAndRemoveUntil(_route, (route) => route.isFirst);
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
