// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statistics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatisticsAdapter extends TypeAdapter<Statistics> {
  @override
  final int typeId = 5;

  @override
  Statistics read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Statistics(
      energyConsume: (fields[0] as List).cast<double>(),
      flatConsume: (fields[1] as List).cast<double>(),
      tokenEarn: (fields[2] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as Token, (v as List).cast<double>())),
      tokenMining: (fields[3] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as Token, (v as List).cast<double>())),
    );
  }

  @override
  void write(BinaryWriter writer, Statistics obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.energyConsume)
      ..writeByte(1)
      ..write(obj.flatConsume)
      ..writeByte(2)
      ..write(obj.tokenEarn)
      ..writeByte(3)
      ..write(obj.tokenMining);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatisticsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
