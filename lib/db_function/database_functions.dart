import 'package:hive_flutter/hive_flutter.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void>allSongs({required List<SongModel> futureSong}) async {
  final songsDatabase = await Hive.openBox<SongMusic>('music_db');
  if (songsDatabase.isEmpty) {
    for (SongModel music in futureSong) {
      songsDatabase.add(SongMusic(
          musicid: music.id.toInt(),
          uri: music.uri.toString(),
          name: music.title,
          artist: music.artist.toString(),
          album: music.album.toString(),
          islike: false,
          path: music.data));
    }
  } else {
    for (SongModel music in futureSong) {
      if (!songsDatabase.values
          .any((element) => element.musicid == music.id.toInt())) {
        songsDatabase.add(SongMusic(
            musicid: music.id.toInt(),
            uri: music.uri.toString(),
            name: music.title,
            artist: music.artist.toString(),
            album: music.album.toString(),
            islike: false,
            path: music.data));
      }
    }
  }
}
Future<List<SongMusic>> getAllSongsFromDatabase() async {
  final songsDatabase = await Hive.openBox<SongMusic>('music_db');
  final songsList = songsDatabase.values.toList();
  songsList.sort((a, b) => a.musicid.compareTo(b.musicid));
  return songsList;
}

