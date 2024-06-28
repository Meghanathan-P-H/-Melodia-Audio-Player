
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:melodia_audioplayer/controls/valueNotifier_fav.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';

Future<void> allSongs({required List<SongModel> futureSong}) async {
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
  SongMusic song =
      songDb.values.firstWhere((song) => song.musicid == fav.musicid);
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

Future<void> addToPlaylist(
    {required String name, required List<int> songid}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  playListDb.add(PlayListmodel(songid: songid, name: name));
  debugPrint("${playListDb.length}");
}

Future<List<PlayListmodel>> getSongsFromPlaylist() async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  return playListDb.values.toList();
}

Future<void> deletePlaylist(int index) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  if (index >= 0 && index < playListDb.length) {
    playListDb.deleteAt(index);
  } else {
    debugPrint("Invalid index for playlist deletion");
  }
}

renameplaylist(
    {required PlayListmodel playlist, required String newname}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  final storedPlaylist = playListDb.get(playlist.key);
  if (storedPlaylist != null) {
    storedPlaylist.name = newname;
    playListDb.put(playlist.key, storedPlaylist);
  }
}

addSongtoPlaylist(
    {required int songid, required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  final addpl = playListDb.get(playlist.key);
  if (addpl!.songid.contains(songid)) {
    addpl.songid.add(songid);
    playListDb.put(playlist.key, addpl);
    debugPrint("$songid added");
  } else {
    debugPrint("song already present in playlist");
  }
}

List<int> songsinPlylist = [];

checkSongOnPlaylist({required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  final addpl = playListDb.get(playlist.key);
  songsinPlylist = addpl!.songid;
}

List<String> playlistNames = [];

checkplaylistNames() async {
  playlistNames.clear();
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  for (int i = 0; i < playListDb.length; i++) {
    final playlist = playListDb.get(i);
    if (playlist != null) {
      playlistNames.add(playlist.name);
      debugPrint("playlist name $i - ${playlist.name}");
    }
  }
  await playListDb.close();
}

removeSongsFromplaylsit(
    {required int songid, required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('list_db');
  final pb = playListDb.get(playlist.key);
  pb!.songid.remove(songid);
  playListDb.put(playlist.key, pb);
  debugPrint("$songid removed");
}

Future<List<SongMusic>> playlistSongs({required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('list_db');
  PlayListmodel? sng = playListDb.get(playlist.key);
  List<int> plSongs = sng!.songid;
  List<SongMusic> allsongs = await getAllSongsFromDatabase();
  List<SongMusic> result = [];
  for (int i = 0; i < allsongs.length; i++) {
    for (int j = 0; j < plSongs.length; j++) {
      if (allsongs[i].musicid == plSongs[j]) {
        result.add(SongMusic(
            musicid: allsongs[i].musicid,
            uri: allsongs[i].uri,
            name: allsongs[i].name,
            artist: allsongs[i].artist,
            album: allsongs[i].album,
            islike: allsongs[i].islike,
            path: allsongs[i].path));
      }
    }
  }
  return result;
}
