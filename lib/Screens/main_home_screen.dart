import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:melodia_audioplayer/Screens/list_of_item_songs.dart';
import 'package:melodia_audioplayer/Screens/settings_drawer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final _audioQuery = OnAudioQuery();
  Future<List<SongModel>>? _futureSong;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _futureSong = _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true);
  }

  Future<void> _refreshSongs() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _futureSong = _audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Transform.translate(
          offset: const Offset(15, 0),
          child: const CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage('asset/images/MelodiaLogo.png'),
            radius: 50,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(
                Icons.settings_suggest_outlined,
                color: Colors.white,
                size: 45,
              ))
        ],
      ),
      drawer:const SettingsDrawer(),
      body: RefreshIndicator(
        onRefresh: _refreshSongs,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Find the best music\nfor your banger',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15.0),
                  width: double.infinity,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: const DecorationImage(
                        image: AssetImage('asset/images/BannerImage.jpg'),
                        fit: BoxFit.fill),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'All Songs',
                    style: TextStyle(
                        fontSize: 26.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                FutureBuilder<List<SongModel>>(
                    future: _futureSong,
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (item.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'NO Songs Found',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListItemWidget(
                                index: index,
                                title: item.data![index].displayNameWOExt,
                                subtitle: item.data![index].artist ??
                                    'Unknown Artist');
                          },
                          itemCount: item.data!.length,
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
