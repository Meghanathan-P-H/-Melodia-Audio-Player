import 'package:flutter/material.dart';
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
    print("Fetched songs: ${songs.length}");
    setState(() {
      allMusics = songs;
      displayedMusics = songs;
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
      List<SongMusic> unmatchedSongs = [];

      for (var song in allMusics) {
        if (song.name.toLowerCase().contains(searchText) ||
            song.artist.toLowerCase().contains(searchText)) {
          matchedSongs.add(song);
        } else {
          unmatchedSongs.add(song);
        }
      }

      setState(() {
        displayedMusics = [...matchedSongs, ...unmatchedSongs];
      });
    }

    // ignore: avoid_print
    print("Filtered songs: ${displayedMusics.length}");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundTheme()),
      child: Scaffold(
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
            color: Colors.white, borderRadius: BorderRadius.circular(30)),
        child: TextField(
          controller: searchController,
          onChanged: (value) {
            _searchSongs();
          },
          decoration: const InputDecoration(
              hintText: 'Search here',
              hintStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              border: InputBorder.none),
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
                  trailing: IconButton(
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onPressed: () {},
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
