// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TokenAdapter extends TypeAdapter<Token> {
  @override
  final int typeId = 3;

  @override
  Token read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Token(
      id: fields[0] as int,
      symbol: fields[1] as String,
      fullName: fields[2] as String,
      count: fields[3] as double,
      isScam: fields[4] as bool,
      dateCreated: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Token obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.symbol)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.count)
      ..writeByte(4)
      ..write(obj.isScam)
      ..writeByte(5)
      ..write(obj.dateCreated);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
