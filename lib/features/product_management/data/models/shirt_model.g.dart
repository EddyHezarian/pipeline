// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shirt_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShirtModelAdapter extends TypeAdapter<ShirtModel> {
  @override
  final int typeId = 2;

  @override
  ShirtModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShirtModel(
      size: fields[1] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ShirtModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.size);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShirtModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
