// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameAdapter extends TypeAdapter<Game> {
  @override
  final int typeId = 0;

  @override
  Game read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Game(
      id: fields[0] as int,
      money: fields[1] as double,
      nick: fields[2] as String,
      date: fields[3] as DateTime,
      currentClicks: fields[5] as int,
      secondsDelay: fields[6] as int,
      gameOver: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Game obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.money)
      ..writeByte(2)
      ..write(obj.nick)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.gameOver)
      ..writeByte(5)
      ..write(obj.currentClicks)
      ..writeByte(6)
      ..write(obj.secondsDelay);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
