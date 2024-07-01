import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class AllSongsPlaylist extends StatefulWidget {
  final PlayListmodel playlistModel;
  const AllSongsPlaylist({required this.playlistModel, super.key});

  @override
  State<AllSongsPlaylist> createState() => _AllSongsPlaylistState();
}

class _AllSongsPlaylistState extends State<AllSongsPlaylist> {
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
      title: const Text(
        'ALL SONGS',
        style: TextStyle(
          color: Colors.white,
          fontSize: 23,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        const SizedBox(height: 10),
        Expanded(
          child: FutureBuilder<List<SongMusic>>(
            future: getAllSongsFromDatabase(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error No Songs Available'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                    child: Text('No songs found',
                        style: TextStyle(color: Colors.white)));
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
      trailing: _buildTrailingIcon(song),
      onTap: () => _navigateToMusicPlayScreen(context, song),
    );
  }

  Widget _buildTrailingIcon(SongMusic song) {
    final isInPlaylist = songsinPlylist.contains(song.musicid);
    return IconButton(
      onPressed: () {
        if (isInPlaylist) {
          removeSongsFromplaylsit(
              songid: song.musicid, playlist: widget.playlistModel);
        } else {
          addSongtoPlaylist(
              songid: song.musicid, playlist: widget.playlistModel);
        }
        checkSongOnPlaylist(playlist: widget.playlistModel);
        setState(() {});
      },
      icon: Icon(
        isInPlaylist ? Icons.check : Icons.add,
        color: Colors.white,
      ),
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
