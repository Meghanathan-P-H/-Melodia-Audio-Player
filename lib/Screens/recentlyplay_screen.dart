import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/controls/valuenotifier_fav.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class RecentlyScreen extends StatefulWidget {
  const RecentlyScreen({super.key});

  @override
  State<RecentlyScreen> createState() => _RecentlyScreenState();
}

class _RecentlyScreenState extends State<RecentlyScreen> {
  @override
  void initState() {
    super.initState();
    _loadRecentlyPlayedSongs();
  }

  Future<void> _loadRecentlyPlayedSongs() async {
    final songs = await recentlyPlayedSongs();
    recentlyPlayedSongsNotifier.updateRecentlyPlayed(songs);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<SongMusic>>(
      valueListenable: recentlyPlayedSongsNotifier,
      builder: (context, displayedMusics, _) {
        return Container(
          decoration: BoxDecoration(gradient: backgroundTheme()),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                _buildAppBar(),
                const SizedBox(height: 15),
                _buildSongList(displayedMusics),
              ],
            ),
          ),
        );
      },
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor:const Color(0xFF282C28),
          title: const Text(
            'Recently Played',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
    );
  }

  Widget _buildSongList(List<SongMusic> displayedMusics) {
    if (displayedMusics.isEmpty) {
      return const Expanded(
        child: Center(
          child: Text('No songs found', style: TextStyle(color: Colors.white)),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: displayedMusics.length,
        itemBuilder: (context, index) {
          final song = displayedMusics[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                'asset/images/musicimage.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              song.name,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              song.artist,
              style: const TextStyle(color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: _buildPopupMenuButton(context, song, index),
            onTap: () => _navigateToMusicPlayScreen(context, song),
          );
        },
      ),
    );
  }

  PopupMenuButton<String> _buildPopupMenuButton(
    BuildContext context,
    SongMusic song,
    int index,
  ) {
    return PopupMenuButton<String>(
      icon: const Icon(
        Icons.more_vert_rounded,
        color: Colors.white,
      ),
      onSelected: (String action) {
        handleActionBotton(context, action, index, song, setState);
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<String>(
            value: 'play',
            child: Text('Play'),
          ),
          PopupMenuItem<String>(
            value: song.islike ? 'remove_favorite' : 'add_favorite',
            child: Text(
              song.islike ? 'Remove from Favorite' : 'Add to Favorite',
            ),
          ),
        ];
      },
    );
  }

  void _navigateToMusicPlayScreen(BuildContext context, SongMusic song) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ScreenMusicPlay(song: song),
      ),
    );
  }
}
