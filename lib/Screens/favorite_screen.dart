import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/controls/valueNotifier_fav.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class ScreenFavorite extends StatefulWidget {
  const ScreenFavorite({super.key});

  @override
  State<ScreenFavorite> createState() => _ScreenFavoriteState();
}

class _ScreenFavoriteState extends State<ScreenFavorite> {
  @override
  void initState() {
    super.initState();
    // Initial load of favorite songs
    _loadFavoriteSong();
  }

  Future<void> _loadFavoriteSong() async {
    final songs = await favoriteSongList();
    favoriteSongsNotifier.updateFavorites(songs);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<SongMusic>>(
      valueListenable: favoriteSongsNotifier,
      builder: (context, displayedMusics, _) {
        return Container(
          decoration: BoxDecoration(gradient: backgroundTheme()),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                _buildAppBar(),
                const Divider(height: 1,),
                const SizedBox(height: 10),
                // _buildSearchBar(),
                // const SizedBox(height: 15),
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
      backgroundColor: Colors.transparent,
      title: const Text(
        'Favorite Songs',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 26,
        ),
      ),
      centerTitle: true,
    );
  }

  // Padding _buildSearchBar() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //     child: Container(
  //       height: 60,
  //       padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
  //       decoration: BoxDecoration(
  //         color: Colors.white,
  //         borderRadius: BorderRadius.circular(30),
  //       ),
  //       child: const TextField(
  //         decoration: InputDecoration(
  //           hintText: 'Search here',
  //           hintStyle: TextStyle(color: Colors.black),
  //           prefixIcon: Icon(Icons.search, color: Colors.black),
  //           border: InputBorder.none,
  //         ),
  //       ),
  //     ),
  //   );
  // }

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
