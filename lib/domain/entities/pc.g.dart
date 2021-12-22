// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pc.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PCAdapter extends TypeAdapter<PC> {
  @override
  final int typeId = 1;

  @override
  PC read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PC(
      id: fields[0] as int,
      name: fields[1] as String,
      cost: fields[2] as double,
      costSell: fields[3] as double,
      power: fields[4] as double,
      energy: fields[5] as double,
      coefIncome: fields[6] as double,
      needLevel: fields[8] as int,
      miningToken: fields[7] as Token?,
    );
  }

  @override
  void write(BinaryWriter writer, PC obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.cost)
      ..writeByte(3)
      ..write(obj.costSell)
      ..writeByte(4)
      ..write(obj.power)
      ..writeByte(5)
      ..write(obj.energy)
      ..writeByte(6)
      ..write(obj.coefIncome)
      ..writeByte(7)
      ..write(obj.miningToken)
      ..writeByte(8)
      ..write(obj.needLevel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PCAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
