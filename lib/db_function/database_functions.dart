import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:melodia_audioplayer/controls/valueNotifier_fav.dart';
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

Future<SongMusic> likeDbFunction(SongMusic fav) async {
  final songDb = await Hive.openBox<SongMusic>('music_db');
  SongMusic song = songDb.values.firstWhere((song) => song.musicid == fav.musicid);
  song.islike = !song.islike;
  await songDb.put(song.key, song);

  
  List<SongMusic> favoriteSongs = await favoriteSongList();
  favoriteSongsNotifier.updateFavorites(favoriteSongs);

  return song;
}



Future<List<SongMusic>> favoriteSongList() async {
  List<SongMusic> songs = await getAllSongsFromDatabase();
  List<SongMusic> favSongs = songs.where((song) {
    return song.islike == true;
  }).toList();
  for (int i = 0; i < favSongs.length; i++) {
    debugPrint('hil;j ${favSongs[i].name}');
  }
  return favSongs;
}
