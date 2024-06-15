import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class ScreenMusicPlay extends StatefulWidget {
 

  @override
  _ScreenMusicPlayState createState() => _ScreenMusicPlayState();
   final SongMusic song;

  const ScreenMusicPlay({super.key, required this.song});
}

class _ScreenMusicPlayState extends State<ScreenMusicPlay> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isSuffling = false;
  bool _isLooping = false;

  @override
  void initState() {
    super.initState();
    _playSong(widget.song);
  }

  Future<void> _playSong(SongMusic song) async {
    await _audioPlayer.setUrl(song.uri);
    _audioPlayer.play();
    setState(() {
      _isPlaying = true;
    });
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _toggleShuffle() {
    setState(() {
      _isSuffling = !_isSuffling;
    });
    _audioPlayer.setShuffleModeEnabled(_isSuffling);
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
    });
    _audioPlayer.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
  }

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
      backgroundColor: Colors.transparent,
      title: const Text(
        'Playing Now',
        style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
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
        const SizedBox(height: 70),
        _buildAlbumArt(),
        const SizedBox(height: 20),
        _buildSongInfo(),
        _buildControls()
      ],
    );
  }

  Widget _buildAlbumArt() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: const DecorationImage(
            image: AssetImage('asset/images/playingdefaultimg.jpg'),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSongInfo() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.song.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.song.artist,
              style: TextStyle(
                color: Colors.grey[400],
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(_isLooping ? Icons.repeat_one : Icons.repeat),
                color: Colors.white,
                onPressed: _toggleLoop,
              ),
              IconButton(
                icon: Icon(_isSuffling ? Icons.shuffle_on : Icons.shuffle),
                color: Colors.white,
                onPressed: _toggleShuffle,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.skip_previous),
                color: Colors.white,
                iconSize: 40,
                onPressed: () {}, // Add functionality if needed
              ),
              IconButton(
                icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                color: Colors.white,
                iconSize: 60,
                onPressed: _playPause,
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                color: Colors.white,
                iconSize: 40,
                onPressed: () {}, // Add functionality if needed
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
