import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/db_model/db_playlistmodel.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
// import 'package:melodia_audioplayer/screens/musicplay_screen.dart';
import 'package:melodia_audioplayer/screens/playlsitopen.dart';
import 'package:melodia_audioplayer/screens/recentlyplay_screen.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class ScreenPlayList extends StatefulWidget {
  const ScreenPlayList({super.key});

  @override
  State<ScreenPlayList> createState() => _ScreenPlayListState();
}

class _ScreenPlayListState extends State<ScreenPlayList> {

  List<String> playlistNames = ['Now playing', 'Recently played'];

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
        appBar: _buildAppBar(context),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: const Text(
        'My Playlist',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 26),
      ),
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
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.0267),
        Expanded(
          child: FutureBuilder<List<PlayListmodel>>(
            future: getSongsFromPlaylist(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error loading playlists'));
              } else {
                List<String> allPlaylist = List.from(playlistNames);
                if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  allPlaylist.addAll(snapshot.data!.map((e) => e.name));
                }
                return _buildGridView(allPlaylist, snapshot.data ?? []);
              }
            },
          ),
        ),
      ],
    );
  }

  GridView _buildGridView(
      List<String> allPlaylist, List<PlayListmodel> playlists) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: MediaQuery.of(context).size.width * 0.08,
        mainAxisSpacing: MediaQuery.of(context).size.width * 0.08,
      ),
      itemCount: allPlaylist.length,
      itemBuilder: (context, index) {
        PlayListmodel? currentPlaylist;
        if (index >= playlistNames.length) {
          currentPlaylist = playlists[index - playlistNames.length];
        }
        return _buildPlaylistContainer(
          allPlaylist[index],
          index < playlistNames.length,
          index,
          currentPlaylist,
        );
      },
    );
  }

  Widget _buildPlaylistContainer(String title, bool isInitialPlaylist,
      int index, PlayListmodel? playlist) {
    bool showMoreOption = title != "Recently played" && title != "Now playing";

    return InkWell(
      onTap: () async{
        if (title == "Recently played") {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const RecentlyScreen(),
            ),
          );
        } else if (title == "Now playing") {
      SongMusic? lastRecentlyPlayedSong = await getLastRecentlyPlayedSong();
      if (lastRecentlyPlayedSong != null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScreenMusicPlay(song: lastRecentlyPlayedSong),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Play Any Song in Home Screen')),
        );
      }
    } else if (playlist != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OpenPlayList(
                playListmodel: playlist,
                playlistname: title,
              ),
            ),
          );
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
          mainAxisAlignment: title == "Recently played" || title == "Now playing"
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            if (showMoreOption)
              _buildPopupMenu(index - playlistNames.length, playlist),
            Icon(
             title == "Now playing" ? Icons.play_circle_outline_rounded : Icons.music_note,
              color: Colors.white,
              size: 48 * MediaQuery.of(context).size.width / 375.0,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0125),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopupMenu(int index, PlayListmodel? playlist) {
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'delete') {
            _showDeleteConfirmationDialog(context, index);
          } else if (value == 'rename') {
            if (playlist != null) {
              _showRenameDialog(context, playlist);
            }
          }
        },
        itemBuilder: (BuildContext context) {
          return [
            const PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete Playlist'),
            ),
            const PopupMenuItem<String>(
              value: 'rename',
              child: Text('Rename Playlist'),
            ),
          ];
        },
        icon: Icon(
          Icons.more_vert,
          color: Colors.white,
          size: 28 * MediaQuery.of(context).size.width / 375.0,
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
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
                setState(() {});
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showRenameDialog(BuildContext context, PlayListmodel playlist) {
    final TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController createController = TextEditingController();
        return Theme(
          data: ThemeData(dialogBackgroundColor: Colors.transparent),
          child: Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.35,
                  maxWidth: MediaQuery.of(context).size.width * 0.7,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(
                        MediaQuery.of(context).size.width * 0.02),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.0375),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text(
                          'Rename Playlist',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.025),
                        TextField(
                          controller: controller,
                          onChanged: (value) {
                            if (value.length <= 10) {
                            } else {
                              createController.text = value.substring(0, 15);
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Enter new name',
                            hintStyle: const TextStyle(
                                color: Colors.white, fontSize: 12),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.02),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.03125),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                )),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.0655),
                            TextButton(
                                onPressed: () async {
                                  final newName = controller.text;
                                  if (newName.isNotEmpty) {
                                    await renameplaylist(
                                        playlist: playlist, newname: newName);
                                    setState(() {});
                                  }
                                  // ignore: use_build_context_synchronously
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
