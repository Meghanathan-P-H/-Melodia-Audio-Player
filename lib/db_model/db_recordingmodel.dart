import 'package:hive_flutter/hive_flutter.dart';

part 'db_recordingmodel.g.dart';

@HiveType(typeId: 4)
class RecordingAudio extends HiveObject {
  @HiveField(0)
  String filePath;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime lastPlayed;

  RecordingAudio({
    required this.filePath,
    required this.title,
    required this.lastPlayed,
  });
}
