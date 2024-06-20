import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/controls/valueNotifier_fav.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';


class ScreenFovorite extends StatefulWidget {
  const ScreenFovorite({super.key});

  @override
  State<ScreenFovorite> createState() => _ScreenFovoriteState();
}

class _ScreenFovoriteState extends State<ScreenFovorite> {
  @override
  void initState() {
    super.initState();
    // Initial load of favorite songs
    _loadFovoriteSong();
  }

  Future<void> _loadFovoriteSong() async {
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
                AppBar(
                  backgroundColor: Colors.transparent,
                  title: const Text('Favorite Songs',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 26)),
                  centerTitle: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Container(
                    height: 60,
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: const TextField(
                      decoration: InputDecoration(
                          hintText: 'Search here',
                          hintStyle: TextStyle(color: Colors.black),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                _buildSongList(displayedMusics),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSongList(List<SongMusic> displayedMusics) {
    return Expanded(
      child: displayedMusics.isEmpty
          ? const Center(
              child: Text('No songs found', style: TextStyle(color: Colors.white)))
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: displayedMusics.length,
              itemBuilder: (context, index) {
                final song = displayedMusics[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    song.artist,
                    style: const TextStyle(color: Colors.white70),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: PopupMenuButton<String>(
                    icon: const Icon(
                      Icons.more_vert_rounded,
                      color: Colors.white,
                    ),
                    onSelected: (String action) {
                      handleActionBotton(
                          context, action, index, song, setState);
                    },
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem<String>(
                          value: 'play',
                          child: Text('Play'),
                        ),
                        PopupMenuItem<String>(
                          value:
                              song.islike ? 'remove_favorite' : 'add_favorite',
                          child: Text(song.islike
                              ? 'Remove from Favorite'
                              : 'Add to Favorite'),
                        )
                      ];
                    },
                  ),
                  onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScreenMusicPlay(song: song),
                    ),
                  );
                  },
                );
              },
            ),
    );
  }
}
