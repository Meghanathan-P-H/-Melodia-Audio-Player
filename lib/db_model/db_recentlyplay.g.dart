// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_recentlyplay.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentlySongsModelAdapter extends TypeAdapter<RecentlySongsModel> {
  @override
  final int typeId = 3;

  @override
  RecentlySongsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentlySongsModel(
      songId: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, RecentlySongsModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.songId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentlySongsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
