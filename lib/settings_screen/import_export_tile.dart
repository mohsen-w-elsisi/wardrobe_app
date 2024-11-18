import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/backend/manager.dart';

class SettingsScreenExportTile extends StatelessWidget {
  const SettingsScreenExportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _export,
      title: const Text("export wardrobe"),
    );
  }

  Future<void> _export() async {
    final json = _clothItemManager.export();
    var jsonAsBytes = Uint8List.fromList(json.runes.toList());
    FilePicker.platform.saveFile(
      bytes: jsonAsBytes,
      fileName: "wardrobe.json",
      allowedExtensions: ["json"],
      dialogTitle: "export wardrobe to file",
    );
  }

  ClothItemManager get _clothItemManager => GetIt.I.get<ClothItemManager>();
}

class SettingsScreenImportTile extends StatelessWidget {
  const SettingsScreenImportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => _showImportModal(context),
      title: const Text("import wardrobe"),
    );
  }

  void _showImportModal(BuildContext context) {
    _ImportModal(context).show();
  }
}

class _ImportModal {
  final _clothItemManager = GetIt.I.get<ClothItemManager>();
  final BuildContext _context;
  String _json = "";

  _ImportModal(this._context);

  void show() {
    showDialog(context: _context, builder: (_) => _build());
  }

  Widget _build() {
    return AlertDialog(
      title: const Text("import"),
      content: TextField(
        onChanged: (value) => _json = value,
      ),
      actions: [
        TextButton(
          onPressed: _dismiss,
          child: const Text("cancel"),
        ),
        TextButton(
          onPressed: _import,
          child: const Text("import"),
        ),
      ],
    );
  }

  void _dismiss() => Navigator.pop(_context);

  void _import() {
    _clothItemManager.import(_json);
    _dismiss();
  }
}
