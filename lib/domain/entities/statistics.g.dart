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
      buyPCs: (fields[0] as List).cast<double>(),
      buyFlats: (fields[1] as List).cast<double>(),
      energyConsume: (fields[2] as List).cast<double>(),
      flatConsume: (fields[3] as List).cast<double>(),
      dealsBuyVolume: (fields[4] as List).cast<double>(),
      dealsSellVolume: (fields[5] as List).cast<double>(),
      tokenEarn: (fields[6] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as int, (v as List).cast<double>())),
      tokenMining: (fields[7] as Map).map((dynamic k, dynamic v) =>
          MapEntry(k as int, (v as List).cast<double>())),
      clickerEarn: (fields[9] as List).cast<double>(),
    )
      ..clickedPC = fields[8] as int
      ..clickedPCCrits = fields[10] as int
      ..countDays = fields[11] as int;
  }

  @override
  void write(BinaryWriter writer, Statistics obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.buyPCs)
      ..writeByte(1)
      ..write(obj.buyFlats)
      ..writeByte(2)
      ..write(obj.energyConsume)
      ..writeByte(3)
      ..write(obj.flatConsume)
      ..writeByte(4)
      ..write(obj.dealsBuyVolume)
      ..writeByte(5)
      ..write(obj.dealsSellVolume)
      ..writeByte(6)
      ..write(obj.tokenEarn)
      ..writeByte(7)
      ..write(obj.tokenMining)
      ..writeByte(8)
      ..write(obj.clickedPC)
      ..writeByte(9)
      ..write(obj.clickerEarn)
      ..writeByte(10)
      ..write(obj.clickedPCCrits)
      ..writeByte(11)
      ..write(obj.countDays);
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
