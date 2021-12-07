// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsAdapter extends TypeAdapter<News> {
  @override
  final int typeId = 6;

  @override
  News read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return News(
      text: fields[0] as String,
      newsTypeValue: fields[2] as int,
      tokenID: fields[1] as int?,
      date: fields[3] as DateTime,
      isScamToken: fields[5] as bool,
      isAllCrypto: fields[6] as bool,
    )..isActivate = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, News obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.tokenID)
      ..writeByte(2)
      ..write(obj.newsTypeValue)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.isActivate)
      ..writeByte(5)
      ..write(obj.isScamToken)
      ..writeByte(6)
      ..write(obj.isAllCrypto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
