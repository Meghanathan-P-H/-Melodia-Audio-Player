// import 'package:flutter/material.dart';
// import 'package:just_audio/just_audio.dart';
// import 'package:melodia_audioplayer/db_function/database_functions.dart';
// import 'package:melodia_audioplayer/db_model/db_model.dart';

// class MusicPlayController extends ChangeNotifier {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isPlaying = false;
//   bool _isShuffling = false;
//   bool _isLooping = false;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;
//   int _currentIndex = 0;
//   late SongMusic _currentSong;

//   MusicPlayController(SongMusic initialSong) {
//   _currentSong = initialSong;
//   _playSong(_currentSong);

//   // Add listener for player state changes
//   _audioPlayer.playerStateStream.listen((playerState) {
//     if (playerState.processingState == ProcessingState.completed) {
//       playNextSong();
//     }
//   });

//   // Initialize shuffle mode
//   toggleShuffle(); // Depending on your initial state preference
// }


//   bool get isPlaying => _isPlaying;
//   bool get isShuffling => _isShuffling;
//   bool get isLooping => _isLooping;
//   Duration get duration => _duration;
//   Duration get position => _position;
//   SongMusic get currentSong => _currentSong;

//   Future<void> _playSong(SongMusic song) async {
//     await _audioPlayer.setUrl(song.uri);
//     _audioPlayer.play();
//     _isPlaying = true;
//     _currentSong = song;
//     notifyListeners();

//     _audioPlayer.durationStream.listen((newDuration) {
//       _duration = newDuration ?? Duration.zero;
//       notifyListeners();
//     });

//     _audioPlayer.positionStream.listen((newPosition) {
//       _position = newPosition;
//       notifyListeners();
//     });
//   }

//   void playPause() {
//     if (_isPlaying) {
//       _audioPlayer.pause();
//     } else {
//       _audioPlayer.play();
//     }
//     _isPlaying = !_isPlaying;
//     notifyListeners();
//   }

//   void toggleShuffle() {
//   _isShuffling = !_isShuffling;
//   _audioPlayer.setShuffleModeEnabled(_isShuffling);
//   if (_isShuffling) {
//     _currentIndex = _audioPlayer.shuffleIndices!.indexOf(_audioPlayer.currentIndex!);
//   } else {
//     _currentIndex = _audioPlayer.currentIndex!;
//   }
//   notifyListeners();
// }



//   void toggleLoop() {
//     _isLooping = !_isLooping;
//     _audioPlayer.setLoopMode(_isLooping ? LoopMode.one : LoopMode.off);
//     notifyListeners();
//   }

//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [minutes, seconds].join(':');
//   }

//   Future<void> playNextSong() async {
//   if (_isShuffling) {
//     _audioPlayer.seekToNext();
//   } else {
//     final songs = await getAllSongsFromDatabase();
//     if (_currentIndex < songs.length - 1) {
//       _currentIndex++;
//       _playSong(songs[_currentIndex]);
//     }
//   }
// }

// Future<void> playPreviousSong() async {
//   if (_isShuffling) {
//     _audioPlayer.seekToPrevious();
//   } else {
//     final songs = await getAllSongsFromDatabase();
//     if (_currentIndex > 0) {
//       _currentIndex--;
//       _playSong(songs[_currentIndex]);
//     }
//   }
// }


//   void seek(Duration position) {
//     _audioPlayer.seek(position);
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }
// }
