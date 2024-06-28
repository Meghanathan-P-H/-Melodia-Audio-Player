import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/screens/musicplay_screen.dart';

void handleActionBotton(BuildContext context, String action, int index,
    SongMusic song, Function(void Function()) setState) async {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  switch (action) {
    case 'play':
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenMusicPlay(song: song),
        ),
      );
      break;
    case 'add_favorite':
      SongMusic updatedSong = await likeDbFunction(song);
      setState(() {
        song.islike = updatedSong.islike;
      });
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Song Added To Favorites'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      break;
    case 'remove_favorite':
      SongMusic updatedSong = await likeDbFunction(song);
      setState(() {
        song.islike = updatedSong.islike;
      });
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('Song Removed From Favorites'),
          duration: Duration(milliseconds: 1500),
        ),
      );
      break;
    case 'playlist':
      showPlaylistBottomSheet(context);

      break;
  }
}

List<String> playlistNames = ["Favorites"];
void showPlaylistBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (BuildContext context) {
      return FractionallySizedBox(
        heightFactor: 1,
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Add to Playlist',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.white,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.0200),
                GestureDetector(
                  onTap: () {
                    checkplaylistNames();
                    showCreatePlaylistBar(context);
                  },
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(
                            MediaQuery.of(context).size.width * 0.03),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.03),
                            color: Colors.white),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.0500),
                      const Text(
                        "CREATE NEW PLAYLIST",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.020),
                Expanded(
                  child: FutureBuilder(
                    future: getSongsFromPlaylist(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<String> allPlayLists = [];
                        if (snapshot.data != null) {
                          allPlayLists.addAll(snapshot.data!
                              .map((playlist) => playlist.name));
                        }
                        allPlayLists.removeWhere((playlist) => playlist == "Favorites"); // Remove Favorites from the list
                        return ListView.builder(
                          itemCount: allPlayLists.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await addSongtoPlaylist(
                                        songid: index,
                                        playlist: snapshot.data![index]);
                                        // ignore: use_build_context_synchronously
                                        Navigator.pop(context);
                                    // ignore: use_build_context_synchronously
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Song added to ${allPlayLists[index]}',
                                        ),
                                        duration:
                                            const Duration(milliseconds: 1500),
                                      ),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(
                                            MediaQuery.of(context).size.width *
                                                0.024),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.024),
                                            color: Colors.white),
                                        child: const Icon(Icons.library_music),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.07,
                                      ),
                                      Text(
                                        allPlayLists[index],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            overflow: TextOverflow.ellipsis),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.0125),
                              ],
                            );
                          }),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

void showCreatePlaylistBar(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      TextEditingController createController = TextEditingController();
      return Theme(
        data: ThemeData(dialogBackgroundColor: Colors.transparent),
        child: Dialog(
          backgroundColor: Colors.transparent,
          insetPadding:const EdgeInsets.all(16.0), // Adjust the padding as needed
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.35,
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color:const Color(0xFF1E1E1E),
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
                        'Add New Playlist',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                      TextField(
                        controller: createController,
                        onChanged: (value) {
                          if (value.length <= 10) {
                          } else {
                            createController.text = value.substring(0, 15);
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter Playlist Name',
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
                          height: MediaQuery.of(context).size.height * 0.03125),
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
                              width: MediaQuery.of(context).size.width * 0.0655),
                          TextButton(
                              onPressed: () {
                                addToPlaylist(
                                    name: createController.text, songid: []);
                                debugPrint(
                                    'Updated Playlist Names: $playlistNames');
                                Navigator.pop(context);
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
