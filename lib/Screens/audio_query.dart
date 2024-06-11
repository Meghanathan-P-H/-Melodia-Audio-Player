import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongFetcher {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Future<List<SongModel>>? futureSong;

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
