// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cloth_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClothItemAdapter extends TypeAdapter<ClothItem> {
  @override
  final int typeId = 1;

  @override
  ClothItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClothItem(
      name: fields[3] as String,
      type: fields[4] as ClothItemType,
      isFavourite: fields[5] as bool,
      attributes: (fields[6] as List).cast<ClothItemAttribute>(),
      matchingItems: (fields[7] as List).cast<String>(),
      dateCreated: fields[2] as DateTime,
      id: fields[1] as String,
      image: fields[8] as Uint8List,
    );
  }

  @override
  void write(BinaryWriter writer, ClothItem obj) {
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
      other is ClothItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClothItemTypeAdapter extends TypeAdapter<ClothItemType> {
  @override
  final int typeId = 2;

  @override
  ClothItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClothItemType.top;
      case 1:
        return ClothItemType.bottom;
      case 2:
        return ClothItemType.jacket;
      default:
        return ClothItemType.top;
    }
  }

  @override
  void write(BinaryWriter writer, ClothItemType obj) {
    switch (obj) {
      case ClothItemType.top:
        writer.writeByte(0);
        break;
      case ClothItemType.bottom:
        writer.writeByte(1);
        break;
      case ClothItemType.jacket:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ClothItemAttributeAdapter extends TypeAdapter<ClothItemAttribute> {
  @override
  final int typeId = 3;

  @override
  ClothItemAttribute read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ClothItemAttribute.sportive;
      case 1:
        return ClothItemAttribute.onFasion;
      case 2:
        return ClothItemAttribute.classic;
      default:
        return ClothItemAttribute.sportive;
    }
  }

  @override
  void write(BinaryWriter writer, ClothItemAttribute obj) {
    switch (obj) {
      case ClothItemAttribute.sportive:
        writer.writeByte(0);
        break;
      case ClothItemAttribute.onFasion:
        writer.writeByte(1);
        break;
      case ClothItemAttribute.classic:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClothItemAttributeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
