import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';


class SongFetcher {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Future<List<SongModel>>? futureSong;

  Future<bool> requestAudioPermission() async {
    PermissionStatus permissionStatus;
    permissionStatus = await Permission.audio.request();

    if (permissionStatus.isGranted) {
      return true;
    } else {
      permissionStatus = await Permission.audio.request();
      if (permissionStatus.isGranted) {
        return true;
      } else if (permissionStatus.isPermanentlyDenied) {
        openAppSettings();
      }
    }
    return false;
  }


  Future<List<SongModel>> fetchSongs() async {
    List<SongModel> futureSong = await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);
    await allSongs(futureSong: futureSong);
    return futureSong;
  }
}
