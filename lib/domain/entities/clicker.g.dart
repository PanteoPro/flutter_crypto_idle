// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clicker.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClickerAdapter extends TypeAdapter<Clicker> {
  @override
  final int typeId = 7;

  @override
  Clicker read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Clicker(
      currentClicks: fields[0] as int,
      maxClicks: fields[1] as int,
      currentDelay: fields[2] as int,
      maxDelay: fields[3] as int,
      minMoney: fields[4] as double,
      maxMoney: fields[5] as double,
      critMoney: fields[6] as double,
      probabilityCrit: fields[7] as double,
      level: fields[8] as int,
      maxLevel: fields[9] as int,
      upgradeCost: fields[10] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Clicker obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.currentClicks)
      ..writeByte(1)
      ..write(obj.maxClicks)
      ..writeByte(2)
      ..write(obj.currentDelay)
      ..writeByte(3)
      ..write(obj.maxDelay)
      ..writeByte(4)
      ..write(obj.minMoney)
      ..writeByte(5)
      ..write(obj.maxMoney)
      ..writeByte(6)
      ..write(obj.critMoney)
      ..writeByte(7)
      ..write(obj.probabilityCrit)
      ..writeByte(8)
      ..write(obj.level)
      ..writeByte(9)
      ..write(obj.maxLevel)
      ..writeByte(10)
      ..write(obj.upgradeCost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClickerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
