import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:melodia_audioplayer/screens/allsongplaylist.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

// ignore: must_be_immutable
class OpenPlayList extends StatefulWidget {
  String playlistname;
  PlayListmodel playListmodel;
  OpenPlayList(
      {required this.playlistname, required this.playListmodel, super.key});

  @override
  State<OpenPlayList> createState() => _OpenPlayListState();
}

class _OpenPlayListState extends State<OpenPlayList> {
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundTheme()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: const Color(0xFF282C28),
      title: Text(
        widget.playlistname,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AllSongsPlaylist(
                    playlistModel: widget.playListmodel,
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            icon: const Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder<List<SongMusic>>(
            future: playlistSongs(playlist: widget.playListmodel),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error No Songs Available'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No songs found',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _buildSongTile(snapshot.data![index]);
                  },
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSongTile(SongMusic song) {
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
      trailing: IconButton(
        onPressed: () {
          removeSongsFromplaylsit(
              songid: song.musicid, playlist: widget.playListmodel);
          setState(() {});
        },
        icon: const Icon(
          Icons.delete_rounded,
          color: Colors.white,
        ),
      ),
      onTap: () => _navigateToMusicPlayScreen(context, song),
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
