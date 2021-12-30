// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FlatAdapter extends TypeAdapter<Flat> {
  @override
  final int typeId = 2;

  @override
  Flat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Flat(
      id: fields[0] as int,
      name: fields[1] as String,
      nameENG: fields[8] as String,
      cost: fields[2] as double,
      costMonth: fields[3] as double,
      countPC: fields[4] as int,
      isBuy: fields[5] as bool,
      isActive: fields[6] as bool,
      level: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Flat obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.costMonth)
      ..writeByte(4)
      ..write(obj.countPC)
      ..writeByte(5)
      ..write(obj.isBuy)
      ..writeByte(6)
      ..write(obj.isActive)
      ..writeByte(7)
      ..write(obj.level)
      ..writeByte(8)
      ..write(obj.nameENG);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FlatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
