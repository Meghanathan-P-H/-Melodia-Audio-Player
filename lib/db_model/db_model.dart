import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class SongMusic extends HiveObject {
  @HiveField(0)
  int musicid;
  @HiveField(1)
  String uri;
  @HiveField(2)
  String name;
  @HiveField(3)
  String artist;
  @HiveField(4)
  String album;
  @HiveField(5)
  bool islike;
  @HiveField(6)
  String path;
}
   
   SongMusic({
    required.this.musicid;
    required.this.uri;
    required.this.name;
    required.this.artist;
    required.this.album;
    required.this.isLike;
    required.this.path;

   })