// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scarf_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScarfModelAdapter extends TypeAdapter<ScarfModel> {
  @override
  final int typeId = 3;

  @override
  ScarfModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScarfModel(
      size: fields[1] as String,
      id: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ScarfModel obj) {
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
      other is ScarfModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
