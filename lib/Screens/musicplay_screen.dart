import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:melodia_audioplayer/controls/backgroundplay.dart';
import 'package:melodia_audioplayer/controls/list_iconhandle.dart';
import 'package:melodia_audioplayer/db_function/database_functions.dart';
import 'package:melodia_audioplayer/db_model/db_model.dart';
import 'package:melodia_audioplayer/widgets/reusing_widgets.dart';

class ScreenMusicPlay extends StatefulWidget {
  final SongMusic song;

  const ScreenMusicPlay({super.key, required this.song});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenMusicPlayState createState() => _ScreenMusicPlayState();
}

class _ScreenMusicPlayState extends State<ScreenMusicPlay> {
  // final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isShuffling = false;
  bool _isLooping = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late SongMusic currentSong;
  List<SongMusic> songList = [];
  List<SongMusic> shuffledSongList = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentSong = widget.song;
    _initializeSongs();
  }

  Future<void> _initializeSongs() async {
    songList = await getAllSongsFromDatabase();
    shuffledSongList = List.from(songList)..shuffle();
    currentIndex = songList.indexOf(currentSong);
    _playSong(currentSong);
  }

Future<void> _playSong(SongMusic song) async {
  await AudioPlayerService().setMediaItem(song.uri, song.name, song.artist,);
  AudioPlayerService().audioPlayer.play();
  if (mounted) {
    setState(() {
      _isPlaying = true;
      currentSong = song;
    });
  }

  //  recently played database
  addSongToRecently(song.musicid);

  //  audio player's duration
  AudioPlayerService().audioPlayer.durationStream.listen((newDuration) {
    if (mounted) {
      setState(() {
        duration = newDuration ?? Duration.zero;
      });
    }
  });

  //  audio player's position
  AudioPlayerService().audioPlayer.positionStream.listen((newPosition) {
    if (mounted) {
      setState(() {
        position = newPosition;
      });
    }
  });

  AudioPlayerService().audioPlayer.playerStateStream.listen((playerState) {
    if (playerState.processingState == ProcessingState.completed) {
      _playNextSong();
    }
  });
}




  void _playPause() {
  if (_isPlaying) {
    AudioPlayerService().audioPlayer.pause();
  } else {
    AudioPlayerService().audioPlayer.play();
  }
  setState(() {
    _isPlaying = !_isPlaying;
  });
}

  void _toggleShuffle() {
    setState(() {
      _isShuffling = !_isShuffling;
    });
    if (_isShuffling) {
      shuffledSongList.shuffle();
      currentIndex = shuffledSongList.indexOf(currentSong);
    } else {
      currentIndex = songList.indexOf(currentSong);
    }
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
    });
    AudioPlayerService().audioPlayer.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _playNextSong() {
    if (_isShuffling) {
      currentIndex = (currentIndex + 1) % shuffledSongList.length;
      _playSong(shuffledSongList[currentIndex]);
    } else {
      currentIndex = (currentIndex + 1) % songList.length;
      _playSong(songList[currentIndex]);
    }
  }

  void _playPreviousSong() {
    if (_isShuffling) {
      currentIndex = (currentIndex - 1) % shuffledSongList.length;
      if (currentIndex < 0) currentIndex += shuffledSongList.length;
      _playSong(shuffledSongList[currentIndex]);
    } else {
      currentIndex = (currentIndex - 1) % songList.length;
      if (currentIndex < 0) currentIndex += songList.length;
      _playSong(songList[currentIndex]);
    }
  }

  void _showFavoriteSnackbar(bool isLiked) {
    final snackBar = SnackBar(
      content: Text(
        isLiked ? 'Song Added To Favorites' : 'Song Removed From Favorites',
      ),
      duration: const Duration(milliseconds: 1500),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: backgroundTheme()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
        'Now Playing',
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
        SizedBox(height: screenHeight * 0.03),
        _buildAlbumArt(screenWidth),
        SizedBox(height: screenHeight * 0.02),
        _buildSongInfo(),
        SizedBox(height: screenHeight * 0.01),
        _buildControls(screenHeight, screenWidth),
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
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentSong.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            currentSong.artist,
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

  Widget _buildControls(double screenHeight, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: screenHeight * 0.02,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: Icon(
                  currentSong.islike ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () async {
                  SongMusic updatedSong = await likeDbFunction(currentSong);
                  setState(() {
                    currentSong = updatedSong;
                  });
                  _showFavoriteSnackbar(updatedSong.islike);
                },
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.playlist_add),
                color: Colors.white,
                onPressed: () {
                  showPlaylistBottomSheet(context, songId: currentSong.musicid);
                },
              ),
            ],
          ),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: const Color(0xFF18D518),
              inactiveTrackColor: Colors.grey,
              trackShape: const RectangularSliderTrackShape(),
              trackHeight: 2.0,
              thumbColor: const Color(0xFF18D518),
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
              overlayColor: const Color(0xFF18D518).withAlpha(32),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 5),
            ),
            child: Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await AudioPlayerService().audioPlayer.seek(position);
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
                icon: Icon(
                  _isLooping ? Icons.repeat_one : Icons.repeat_rounded,
                ),
                color: Colors.white,
                onPressed: _toggleLoop,
              ),
              IconButton(
                icon: Icon(
                  _isShuffling
                      ? Icons.shuffle_on_outlined
                      : Icons.shuffle_rounded,
                ),
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
                onPressed: _playPreviousSong,
              ),
              IconButton(
                icon: Icon(
                  _isPlaying
                      ? Icons.pause_circle_filled_rounded
                      : Icons.play_circle_fill_rounded,
                ),
                color: const Color(0xFF18D518),
                iconSize: 60,
                onPressed: _playPause,
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                color: Colors.white,
                iconSize: 40,
                onPressed: _playNextSong,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  // AudioPlayerService().audioPlayer.dispose();
  //   super.dispose();
  // }
}
