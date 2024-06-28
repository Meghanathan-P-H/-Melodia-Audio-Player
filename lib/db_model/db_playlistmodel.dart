import 'package:hive_flutter/hive_flutter.dart';
part 'db_playlistmodel.g.dart';
@HiveType(typeId: 2)
class PlayListmodel extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  List<int> songid;
  PlayListmodel({required this.songid, required this.name});
}
