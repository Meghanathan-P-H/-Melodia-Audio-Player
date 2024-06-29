import 'package:hive_flutter/hive_flutter.dart';
part 'db_recentlyplay.g.dart';
@HiveType(typeId: 3)
class RecentlySongsModel extends HiveObject {
  @HiveField(0)
  int songId;
  RecentlySongsModel({required this.songId});
}
