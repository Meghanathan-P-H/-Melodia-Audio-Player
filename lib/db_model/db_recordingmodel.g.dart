// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_recordingmodel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordingAudioAdapter extends TypeAdapter<RecordingAudio> {
  @override
  final int typeId = 4;

  @override
  RecordingAudio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordingAudio(
      filePath: fields[0] as String,
      title: fields[1] as String,
      lastPlayed: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RecordingAudio obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.filePath)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.lastPlayed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordingAudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
