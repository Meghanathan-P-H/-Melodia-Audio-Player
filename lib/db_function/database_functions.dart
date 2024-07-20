
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:melodia_audioplayer/controls/valueNotifier_fav.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:melodia_audioplayer/db_model/db_recentlyplay.dart';
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

// <--- PlayList Fuctions--->


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

Future<void> addSongtoPlaylist(
    {required int songid, required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  final addpl = playListDb.get(playlist.key);
  if (addpl != null && !addpl.songid.contains(songid)) {
    addpl.songid.add(songid);
    playListDb.put(playlist.key, addpl);
    debugPrint("$songid added");
  } else {
    debugPrint("Song already present in playlist");
  }
}

List<int> songsinPlylist = [];

Future<void> checkSongOnPlaylist({required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  final addpl = playListDb.get(playlist.key);
  if (addpl != null) {
    songsinPlylist = addpl.songid;
  }
}

List<String> playlistNames = [];


Future<void> checkplaylistNames() async {
  playlistNames.clear();
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  for (int i = 0; i < playListDb.length; i++) {
    final playlist = playListDb.getAt(i);
    if (playlist != null) {
      playlistNames.add(playlist.name);
      debugPrint("playlist name $i - ${playlist.name}");
    }
  }
  
  // await playListDb.close();
}

Future<void> removeSongsFromplaylsit(
    {required int songid, required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  final pb = playListDb.get(playlist.key);
  if (pb != null) {
    pb.songid.remove(songid);
    playListDb.put(playlist.key, pb);
    debugPrint("$songid removed");
  }
}

Future<void> renameplaylist(
    {required PlayListmodel playlist, required String newname}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  final storedPlaylist = playListDb.get(playlist.key);
  if (storedPlaylist != null) {
    storedPlaylist.name = newname;
    playListDb.put(playlist.key, storedPlaylist);
  }
}


Future<List<SongMusic>> playlistSongs({required PlayListmodel playlist}) async {
  final playListDb = await Hive.openBox<PlayListmodel>('playlist_db');
  PlayListmodel? sng = playListDb.get(playlist.key);
  if (sng == null) return [];

  List<int> plSongs = sng.songid;
  List<SongMusic> allsongs = await getAllSongsFromDatabase();
  List<SongMusic> result = [];

  for (int songId in plSongs) {
    for (SongMusic song in allsongs) {
      if (song.musicid == songId) {
        result.add(song);
      }
    }
  }

  return result;
}

// <---Recently Plays Fuctions--->

void addSongToRecently(int songindex) async {
  final recentlyDb = await Hive.openBox<RecentlySongsModel>('recently_db');
  List<RecentlySongsModel> songs = recentlyDb.values.toList();
  for (int i = 0; i < songs.length; i++) {
    if (songs[i].songId == songindex) {
      recentlyDb.delete(songs[i].key);
      break;
    }
  }
  recentlyDb.add(RecentlySongsModel(songId:songindex));
}

Future<List<SongMusic>> recentlyPlayedSongs() async {
 final recentlyDb = await Hive.openBox<RecentlySongsModel>('recently_db');
  List<RecentlySongsModel> songs = recentlyDb.values.toList();
  List<SongMusic> allSongs = await  getAllSongsFromDatabase();
  List<SongMusic> recents = [];
  for (int i = 0; i < songs.length; i++) {
    for (int j = 0; j < allSongs.length; j++) {
      if (songs[i].songId == allSongs[j].musicid) {
        recents.add(allSongs[j]);
      }
    }
  }

  return recents.reversed.toList();
}

Future<SongMusic?> getLastRecentlyPlayedSong() async {
  final recentlyDb = await Hive.openBox<RecentlySongsModel>('recently_db');
  if (recentlyDb.isNotEmpty) {
    final lastRecentlyPlayed = recentlyDb.values.last;
    List<SongMusic> allSongs = await getAllSongsFromDatabase();
    for (SongMusic song in allSongs) {
      if (song.musicid == lastRecentlyPlayed.songId) {
        return song;
      }
    }
  }
  return null;
}
