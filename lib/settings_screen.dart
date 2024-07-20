import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          const SliverAppBar.medium(
            flexibleSpace: FlexibleSpaceBar(
              title: Text("settings"),
            ),
          ),
          SliverList.list(
            children: [
              ListTile(
                title: const Text("dark theme"),
                trailing: Switch(
                  value: false,
                  onChanged: (value) {},
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
