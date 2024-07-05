import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal();

  final AudioPlayer audioPlayer = AudioPlayer();

  Future<void> setMediaItem(String url, String title, String artist,
      {String? artwork}) async {
        final artUri = artwork != null && artwork.isNotEmpty
        ? Uri.parse(artwork)
        : Uri.parse('asset:///assets/images/pngegg.png');
    await audioPlayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(url),
        tag: MediaItem(
          id: url,
          album: 'Album Name',
          title: title,
          artist: artist,
          artUri:  artUri,
        ),
      ),
    );
  }
}
