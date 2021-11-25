// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PriceTokenAdapter extends TypeAdapter<PriceToken> {
  @override
  final int typeId = 4;

  @override
  PriceToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PriceToken(
      date: fields[0] as DateTime,
      cost: fields[1] as double,
      tokenId: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PriceToken obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.cost)
      ..writeByte(2)
      ..write(obj.tokenId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PriceTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
