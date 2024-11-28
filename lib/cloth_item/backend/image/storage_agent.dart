import 'dart:typed_data';

import 'package:sqflite/sqflite.dart';
import 'package:wardrobe_app/cloth_item/backend/image/manager.dart';

const _sqliteMasterTableName = "sqlite_master";

const _databaseName = "images.db";
const _tableName = "Images";
const _idFieldName = "id";
const _imageFieldName = "image";

class ClothItemImageSqliteStorageAgent implements ClothItemImageStorageAgent {
  late final Database _db;

  Future<void> initialise() async {
    _db = await _DataBaseInitializer().getDB();
  }

  @override
  Future<Uint8List> getImage(String id) async {
    final retrievedImages = await _db
        .query(_tableName, where: "$_idFieldName = ?", whereArgs: [id]);
    final imageBytes = retrievedImages[0][_imageFieldName] as Uint8List;
    return imageBytes;
  }

  @override
  void saveImage(String id, Uint8List imageBytes) {
    _db.insert(_tableName, {
      _idFieldName: id,
      _imageFieldName: imageBytes,
    });
  }

  @override
  void deleteImage(String id) {
    _db.delete(
      _tableName,
      where: "$_idFieldName = ?",
      whereArgs: [id],
    );
  }

  @override
  void deleteAllImages() {
    _db.delete(_tableName);
  }

  @override
  Future<List<String>> savedIDs() async {
    final queryResults = await _db.query(
      _tableName,
      columns: [_idFieldName],
    );
    return [for (final result in queryResults) result[_idFieldName]! as String];
  }
}

class _DataBaseInitializer {
  late final Database _db;

  Future<Database> getDB() async {
    await _openDatabase();
    if (await _tableNotExisting) await _createTable();
    return _db;
  }

  Future<void> _openDatabase() async {
    _db = await openDatabase(_databaseName);
  }

  Future<bool> get _tableNotExisting async {
    final existingTablesOfCorrectName = await _db.query(
      _sqliteMasterTableName,
      where: "name = ?",
      whereArgs: [_tableName],
    );
    return existingTablesOfCorrectName.isEmpty;
  }

  Future<void> _createTable() async {
    await _db.execute(
      "CREATE TABLE $_tableName("
      "$_idFieldName TEXT PRIMARY KEY,"
      "$_imageFieldName BLOB"
      ")",
    );
  }
}
