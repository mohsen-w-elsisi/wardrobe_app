import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

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
      content: const Text(
          "Deleted data cannot be recovered. Consider exporting your wardrobe first."),
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
    _close(context);
    GetIt.I<ClothItemDeleter>().clearWardrobe();
    _showConfirmationSnackbar(context);
  }

  void _showConfirmationSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("the whole wardrobe has been cleared"),
      ),
    );
  }

  void _close(BuildContext context) => Navigator.of(context).pop();
}
