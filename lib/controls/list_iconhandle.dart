import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';

void handleActionBotton(BuildContext context, String action, int index,
    SongMusic song, Function(void Function()) setState) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  switch (action) {
    case 'play':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenMusicPlay(song: song),
        ),
      );
      break;
    case 'add_favorite':
      SongMusic updatedSong = await likeDbFunction(song);
      setState(() {
        song.islike = updatedSong.islike;
      });
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Song Added To Favorites'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      break;
    case 'remove_favorite':
      SongMusic updatedSong = await likeDbFunction(song);
      setState(() {
        song.islike = updatedSong.islike;
      });
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Song Removed From Favorites'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      break;
    case 'playlist':
       showPlaylistBottomSheet(context);
      
      break;
  }
}

void showPlaylistBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 1,
        child: Container(
          decoration:const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.playlist_add, color: Colors.white),
                title: Text('Add to New Playlist', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Handle adding to a new playlist
                },
              ),
              // Add more ListTiles or other widgets as needed
            ],
          ),
        ),
      );
    },
  );
}