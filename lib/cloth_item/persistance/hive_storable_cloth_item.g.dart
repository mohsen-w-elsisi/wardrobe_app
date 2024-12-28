// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_storable_cloth_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveStorableClothItemAdapter extends TypeAdapter<HiveStorableClothItem> {
  @override
  final int typeId = 6;

  @override
  HiveStorableClothItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveStorableClothItem(
      fields[1] as String,
      fields[3] as String,
      fields[4] as int,
      fields[5] as bool,
      (fields[6] as List).cast<int>(),
      (fields[7] as List).cast<String>(),
      fields[2] as DateTime,
      fields[8] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, HiveStorableClothItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj._id)
      ..writeByte(2)
      ..write(obj._dateCreated)
      ..writeByte(3)
      ..write(obj._name)
      ..writeByte(4)
      ..write(obj._type)
      ..writeByte(5)
      ..write(obj._isFavourite)
      ..writeByte(6)
      ..write(obj._attributes)
      ..writeByte(7)
      ..write(obj._matchingItems)
      ..writeByte(8)
      ..write(obj._image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveStorableClothItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
