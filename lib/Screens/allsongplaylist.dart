import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/screens/permission_provider.dart';
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
        body: Column(
          children: [
            AppBar(
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
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: FutureBuilder(
                    future: getAllSongsFromDatabase(),
                    builder: (context, item) {
                      if (item.data == null) {
                        SongFetcher();
                        return const Center(child: CircularProgressIndicator());
                      } else if (item.data!.isEmpty) {
                        return const Center(
                            child: Text('No songs found',
                                style: TextStyle(color: Colors.white)));
                      } else if (item.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (item.hasError) {
                        return const Center(
                          child: Text('Error No Songs Available'),
                        );
                      } else {
                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: item.data!.length,
                          itemBuilder: (context, index) {
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
                                  item.data![index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  item.data![index].artist,
                                  style: const TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing:songsinPlylist.contains(item.data![index].musicid)?IconButton(onPressed: () {
                                                    removeSongsFromplaylsit(
                                                        songid: item
                                                            .data![index].musicid,
                                                             playlist: widget.playlistModel);
                                                    checkSongOnPlaylist(
                                                        playlist: widget.playlistModel);
                                                    setState(() {});
                                                  },
                                                  icon:const Icon(
                                                    Icons.check,
                                                    color: Colors.white,
                                                  ),):IconButton(onPressed: () {
                                                    addSongtoPlaylist(
                                                        songid: item
                                                            .data![index]
                                                            .musicid,
                                                        playlist: widget
                                                            .playlistModel);
                                                    checkSongOnPlaylist(
                                                        playlist: widget
                                                            .playlistModel);
                                                    setState(() {});
                                                  },
                                                  icon:const Icon(
                                                    Icons.add,
                                                    color: Colors.white,
                                                  )),
                                onTap: () {
                                  final song = item.data![index];
                                  _navigateToMusicPlayScreen(context, song);
                                });
                          },
                        );
                      }
                    }))
          ],
        ),
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
