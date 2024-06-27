import 'package:flutter/material.dart';
import 'package:melodia_audioplayer/Screens/list_of_item_songs.dart';
import 'package:melodia_audioplayer/Screens/settings_drawer.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/screens/permission_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final SongFetcher _songFetcher = SongFetcher();
  Future<List<SongMusic>>? _futureSongs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _loadSongs();
  }

  Future<void> _loadSongs() async {
    List<SongModel> fetchedSongs = await _songFetcher.fetchSongs();
    await allSongs(futureSong: fetchedSongs);
    setState(() {
      _futureSongs = getAllSongsFromDatabase();
    });
  }

  Future<void> _refreshSongs() async {
    await Future.delayed(const Duration(seconds: 1));
    await _loadSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      appBar: _buildAppbar(),
      drawer: const SettingsDrawer(),
      body: RefreshIndicator(onRefresh: _refreshSongs, child: _buildBody()),
    );
  }

  AppBar _buildAppbar() {
    return AppBar(
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
          ),
        )
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildHeaderText(),
            _buildBannerImage(),
            _buildSectionTitle('All Songs'),
            _buildSongList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return const Padding(
      padding: EdgeInsets.only(left: 20.0),
      child: Text(
        'Find the best music\nfor your banger',
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildBannerImage() {
    return Container(
      margin: const EdgeInsets.all(15.0),
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: const DecorationImage(
          image: AssetImage('asset/images/BannerImage.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 26.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildSongList() {
  return FutureBuilder<List<SongMusic>>(
      future: _futureSongs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.data == null || snapshot.data!.isEmpty) {
          return const Center(
            child: Text(
              'NO Songs Found',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          );
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListItemWidget(
                  index: index,
                  song: snapshot.data![index]);
            },
            itemCount: snapshot.data!.length,
          );
        }
      });
}
}
