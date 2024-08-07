import 'dart:async';

import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({super.key});

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  List<SongMusic> allMusics = [];
  List<SongMusic> displayedMusics = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  Future<void> fetchSongs() async {
    final songs = await getAllSongsFromDatabase();
    // ignore: avoid_print
    print("all songs here done");
    setState(() {
      allMusics = songs..sort((a, b) => a.name.compareTo(b.name));
      displayedMusics = List.from(allMusics);
    });
  }

  void _searchSongs() {
    final searchText = searchController.text.toLowerCase();
    if (searchText.isEmpty) {
      setState(() {
        displayedMusics = List.from(allMusics);
      });
    } else {
      List<SongMusic> matchedSongs = [];
      for (var song in allMusics) {
        if (song.name.toLowerCase().contains(searchText) ||
            song.artist.toLowerCase().contains(searchText)) {
          matchedSongs.add(song);
        }
      }

      setState(() {
        displayedMusics = matchedSongs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundTheme()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Column(
          children: [_buildAppbar(), _buildSearchContent(), _buildSongList()],
        ),
      ),
    );
  }

  // Build the Search Screen Appbar
  AppBar _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Search Songs',
        style: TextStyle(
            color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Stacked Background Image and Search Content
  Widget _buildSearchContent() {
    return Stack(
      children: [_buildBackgraoundImage(), _buildSearchBar()],
    );
  }

  // Set the background image
  Container _buildBackgraoundImage() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          image: DecorationImage(
        image: AssetImage('asset/images/serchscreenimagebc.png'),
        fit: BoxFit.cover,
      )),
    );
  }

  // Build the Search Bar
  Positioned _buildSearchBar() {
  return Positioned(
    left: 16,
    right: 16,
    bottom: 1,
    child: Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          _searchSongs();
        },
        decoration: InputDecoration(
          hintText: 'Search here',
          hintStyle: const TextStyle(color: Colors.black),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black,
          ),
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () {
              searchController.clear();
              _searchSongs(); // Call the search function to update the UI
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
          border: InputBorder.none,
        ),
      ),
    ),
  );
}


  // Listing all songs in this widget
  Widget _buildSongList() {
    return Expanded(
      child: displayedMusics.isEmpty
          ? const Center(
              child:
                  Text('No songs found', style: TextStyle(color: Colors.white)))
          : ListView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                );
              },
            ),
    );
  }
}
