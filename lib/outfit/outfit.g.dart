// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outfit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OutfitAdapter extends TypeAdapter<Outfit> {
  @override
  final int typeId = 4;

  @override
  Outfit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Outfit(
      items: (fields[1] as List).cast<String>(),
      id: fields[0] as String,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Outfit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.items.toList())
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OutfitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
