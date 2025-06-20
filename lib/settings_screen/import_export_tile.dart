import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:wardrobe_app/cloth_item/domain/use_cases/use_cases.dart';

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
    final json = await GetIt.I<ClothItemExporter>().export();
    final jsonAsBytes = Uint8List.fromList(json.runes.toList());
    _saveBytesToFile(jsonAsBytes);
  }

  void _saveBytesToFile(Uint8List jsonAsBytes) {
    FilePicker.platform.saveFile(
      bytes: jsonAsBytes,
      fileName: "wardrobe.json",
      allowedExtensions: ["json"],
      dialogTitle: "export wardrobe to file",
    );
  }
}

class SettingsScreenImportTile extends StatelessWidget {
  const SettingsScreenImportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: _import,
      title: const Text("import wardrobe"),
    );
  }

  Future<void> _import() async {
    final result = await _selectFile();
    if (result != null) {
      final jsonText = await result.xFiles.first.readAsString();
      GetIt.I<ClothItemImporter>().import(jsonText);
    }
  }

  Future<FilePickerResult?> _selectFile() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["json"],
      dialogTitle: "select wardrobe file",
    );
  }
}
