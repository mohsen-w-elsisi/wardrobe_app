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
      id: fields[1] as String,
      name: fields[3] as String,
      image: fields[8] as Uint8List,
      dateCreated: fields[2] as DateTime,
      type: fields[4] as int,
      attributes: (fields[6] as List).cast<int>(),
      isFavourite: fields[5] as bool,
      matchingItems: (fields[7] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveStorableClothItem obj) {
    writer
      ..writeByte(8)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.dateCreated)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.isFavourite)
      ..writeByte(6)
      ..write(obj.attributes)
      ..writeByte(7)
      ..write(obj.matchingItems)
      ..writeByte(8)
      ..write(obj.image);
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
