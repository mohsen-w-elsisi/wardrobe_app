import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/manager.dart';

class SettingsScreenClearWardrobeTile extends StatelessWidget {
  const SettingsScreenClearWardrobeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "clear wardobe",
        style: TextStyle(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
      onTap: () => _askToDeleteAllWardrobe(context),
    );
  }

  void _askToDeleteAllWardrobe(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const _Dialog(),
    );
  }
}

class _Dialog extends StatelessWidget {
  const _Dialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure you want to delete everything?"),
      content: const Text("deleted data cannot be recovered."),
      actions: [
        TextButton(
          onPressed: () => _close(context),
          child: const Text("cancel"),
        ),
        FilledButton(
          onPressed: () => _deleteAll(context),
          child: const Text("delete"),
        ),
      ],
    );
  }

  void _deleteAll(BuildContext context) {
    clothItemManager.deleteAllItems();
    _close(context);
    _showConfirmationSnackbar(context);
  }

  ClothItemManager get clothItemManager => GetIt.I.get<ClothItemManager>();

  void _showConfirmationSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("the whole wardrobe has been cleared"),
      ),
    );
  }

  void _close(BuildContext context) => Navigator.of(context).pop();
}
