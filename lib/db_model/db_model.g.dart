// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SongMusicAdapter extends TypeAdapter<SongMusic> {
  @override
  final int typeId = 1;

  @override
  SongMusic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SongMusic(
      musicid: fields[0] as int,
      uri: fields[1] as String,
      name: fields[2] as String,
      artist: fields[3] as String,
      album: fields[4] as String,
      islike: fields[5] as bool,
      path: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SongMusic obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.musicid)
      ..writeByte(1)
      ..write(obj.uri)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.artist)
      ..writeByte(4)
      ..write(obj.album)
      ..writeByte(5)
      ..write(obj.islike)
      ..writeByte(6)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SongMusicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
