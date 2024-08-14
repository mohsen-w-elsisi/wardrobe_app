import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'manager.dart';

class OutfitListScreen extends StatelessWidget {
  final outfitManager = GetIt.I.get<OutfitManager>();

  OutfitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar.medium(
            title: Text("saved outfits"),
          ),
          SliverList.list(
            children: [
              for (final outfit in outfitManager.outfits)
                ListTile(
                  title: Text(outfit.name),
                )
            ],
          )
        ],
      ),
    );
  }
}
