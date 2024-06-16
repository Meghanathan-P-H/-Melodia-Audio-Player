import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class ScreenMusicPlay extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _ScreenMusicPlayState createState() => _ScreenMusicPlayState();
  final SongMusic song;

  const ScreenMusicPlay({super.key, required this.song});
}

class _ScreenMusicPlayState extends State<ScreenMusicPlay> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isShuffling = false;
  bool _isLooping = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int currentIndex = 0;

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
    // Listen for changes in the audio player's duration
    _audioPlayer.durationStream.listen((newDuration) {
      setState(() {
        duration = newDuration ?? Duration.zero;
      });
    });
    // Listen for changes in the audio player's position
    _audioPlayer.positionStream.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
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
      _isShuffling = !_isShuffling;
    });
    _audioPlayer.setShuffleModeEnabled(_isShuffling);
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
    });
    _audioPlayer.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return [minutes, seconds].join(':');
  }
  
//   void skipNextSong() async {
//   int nextIndex = (currentIndex + 1) % song.length;
//   await _playSong(index: nextIndex);
//   setState(() {
//     currentIndex = nextIndex;
//   });
// }

// void skipPreviousSong() async {
//   int prevIndex = (currentIndex - 1 + song.length) % song.length;
//   await _playSong(index: prevIndex);
//   setState(() {
//     currentIndex = prevIndex;
//   });
// }

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
  final mediaQuery = MediaQuery.of(context);
  final screenHeight = mediaQuery.size.height;
  final screenWidth = mediaQuery.size.width;

  return Column(
    children: [
      SizedBox(height: screenHeight * 0.05), // 5% of screen height
      _buildAlbumArt(screenWidth),
      SizedBox(height: screenHeight * 0.03), // 3% of screen height
      _buildSongInfo(),
      const Spacer(),
      _buildControls(screenHeight, screenWidth),
      SizedBox(height: screenHeight * 0.02), // 2% of screen height
    ],
  );
}

  Widget _buildAlbumArt(double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image:const DecorationImage(
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
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.song.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            widget.song.artist,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 18,
              overflow: TextOverflow.clip,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControls(double screenHeight,double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
      child: Column(
        children: [
          SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor:const Color(0xFF18D518), // Optional: Makes the track transparent
            inactiveTrackColor: Colors.grey, // Optional: Changes the inactive track color
            trackShape:const RectangularSliderTrackShape(), // Optional: Customizes the shape of the track
            trackHeight: 2.0, // Optional: Adjusts the height of the track
            thumbColor:const Color(0xFF18D518), // Sets the thumb color to green
            thumbShape:const RoundSliderThumbShape(enabledThumbRadius: 10), // Optional: Customizes the thumb shape
            overlayColor:const Color(0xFF18D518).withAlpha(32), // Optional: Changes the overlay color around the thumb
            overlayShape:const RoundSliderOverlayShape(overlayRadius: 5), // Optional: Customizes the overlay shape
          ),
          child: Slider(
            min: 0,
            max: duration.inSeconds.toDouble(),
            value: position.inSeconds.toDouble(),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await _audioPlayer.seek(position);
            },
          ),
        ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatTime(position),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  formatTime(duration - position),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(_isLooping ? Icons.repeat_one : Icons.repeat_rounded),
                color: Colors.white,
                onPressed: _toggleLoop,
              ),
              IconButton(
                icon: Icon(_isShuffling ? Icons.shuffle_on : Icons.shuffle_rounded),
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
                icon: Icon(_isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_fill_rounded),
                color:const Color(0xFF18D518),
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
