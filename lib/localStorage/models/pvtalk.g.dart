// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pvtalk.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PvTalkAdapter extends TypeAdapter<PvTalk> {
  @override
  final int typeId = 1;

  @override
  PvTalk read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PvTalk(
      question: fields[0] as String,
      answer: fields[1] as String,
      createdAt: fields[2] as DateTime,
      id: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, PvTalk obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.answer)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PvTalkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
