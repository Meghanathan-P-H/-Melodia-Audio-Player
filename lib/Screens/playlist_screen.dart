import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:melodia_audioplayer/screens/playlsitopen.dart';
import 'package:melodia_audioplayer/screens/recentlyplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';


class ScreenPlayList extends StatefulWidget {
  const ScreenPlayList({super.key});

  @override
  State<ScreenPlayList> createState() => _ScreenPlayListState();
}

class _ScreenPlayListState extends State<ScreenPlayList> {
  List<String> playlistNames = ['Recently played'];

  void refreshPlaylists() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF7D7D7D), Color(0xED262626)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              title: const Text('My Playlist',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26)),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                       showCreatePlaylistBar(context, refreshPlaylists);
                    },
                    icon: const Icon(
                      Icons.add_circle_outline_rounded,
                      color: Colors.white,
                      size: 36,
                    ))
              ],
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.0267),
            Expanded(
                child: FutureBuilder(
                    future: getSongsFromPlaylist(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        List<String> allPlaylist = List.from(playlistNames);
                        allPlaylist.addAll(snapshot.data!.map((e) => e.name));
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing:
                                MediaQuery.of(context).size.width * 0.08,
                            mainAxisSpacing:
                                MediaQuery.of(context).size.width * 0.08,
                          ),
                          itemCount: allPlaylist.length,
                          itemBuilder: (context, index) {
                            PlayListmodel? currentplaylist;
                            if (index < playlistNames.length) {
                              currentplaylist = null;
                            } else {
                              int plid = index - playlistNames.length;
                              if (plid < snapshot.data!.length) {
                                currentplaylist = snapshot.data![plid];
                              } else {
                                currentplaylist = null;
                              }
                            }
                            return buildContainer(
                              allPlaylist[index],
                              index < playlistNames.length,
                              index,
                              currentplaylist,
                            );
                          },
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
  buildContainer(String title, bool isintialplaylist, int index, PlayListmodel? playlist){
    bool showmoreoption = true;
if (title == "Recently played") {
  showmoreoption = false;
}
    return InkWell(
  onTap: () {
    if (title == "Recently played") {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) =>const RecentlyScreen(),
      ));
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => OpenPlayList(
                  playListmodel: playlist!,
                  playlistname: title,
              )));
    }
  },
  child: Container(
    width: MediaQuery.of(context).size.width * 0.2667,
    height: MediaQuery.of(context).size.width * 0.2667,
    decoration: BoxDecoration(
      gradient: widgetbackgroundTm(),
      borderRadius:
          BorderRadius.circular(MediaQuery.of(context).size.width * 0.04),
    ),
    child: Column(
      mainAxisAlignment:
          (title == "Recently played")
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
      children: [
        if (showmoreoption)
          Align(
            alignment: Alignment.topRight,
            child: PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      showDeleteConfirmationDialog(context, index - playlistNames.length);
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete Playlist'),
                      ),
                    ];
                  },
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 28 * MediaQuery.of(context).size.width / 375.0,
                  ),
                ),
          ),
        Icon(
          Icons.music_note,
          color: Colors.white,
          size: 48 * MediaQuery.of(context).size.width / 375.0,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
        Text(
          title,
          style:const TextStyle(
            color: Colors.white,
            fontSize: 14 ,
          ),
        ),
      ],
    ),
  ),
);
}
void showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Playlist'),
          content: const Text('Are you sure you want to delete this playlist?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                deletePlaylist(index);
                Navigator.of(context).pop();
                setState(() {
                  
                });
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}